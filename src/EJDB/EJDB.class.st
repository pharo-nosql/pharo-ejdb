Class {
	#name : #EJDB,
	#superclass : #EJDBExternalPointer,
	#instVars : [
		'collections'
	],
	#category : #EJDB
}

{ #category : #private }
EJDB class >> ejdbOpen: opts on: ejdbp [
	
	^ self ffiCall: #(iwrc ejdb_open(const EJDB_OPTS *opts, EJDB *ejdbp))
]

{ #category : #opening }
EJDB class >> open: aName [
	
	^ self open: aName mode: 0
]

{ #category : #private }
EJDB class >> open: aName mode: mode [
	| options path |

	options := EJDB_OPTS new.
	path := ExternalAddress fromString: (FileLocator imageDirectory / 'example.db') fullName.
	options kv
		path: path;
		oflags: mode.

	^ [ self openOptions: options ]
		ensure: [ path free ]
]

{ #category : #private }
EJDB class >> openOptions: options [
	| instance |

	instance := self new.
	self validateResult: (self ejdbOpen: options on: instance).
	^ instance
]

{ #category : #opening }
EJDB class >> openReadOnly: aName [
	
	^ self open: aName mode: IWKV_RDONLY
]

{ #category : #opening }
EJDB class >> openTrancate: aName [
	
	^ self open: aName mode: IWKV_TRUNC
]

{ #category : #'opening/closing' }
EJDB >> close [

	self validateResult: self ejdb_close
]

{ #category : #accessing }
EJDB >> collectionNamed: aName [

	^ collections 
		at: aName 
		ifAbsentPut: [ EJDBCollection newDatabase: self name: aName ]
]

{ #category : #accessing }
EJDB >> collectionNames [

	^ (self meta toJSONDictionary at: #collections) 
		collect: [ :each | each at: #name ]
]

{ #category : #'private primitives' }
EJDB >> ejdb_close [
 
	self ffiCall: #(iwrc ejdb_close(EJDB *self))
]

{ #category : #'private primitives' }
EJDB >> ejdb_get_meta: jblp [

	^ self ffiCall: #(iwrc ejdb_get_meta(self, JBL *jblp))
]

{ #category : #'private primitives' }
EJDB >> ejdb_remove_collection: coll [

	self ffiCall: #(iwrc ejdb_remove_collection(self, const char *coll))
]

{ #category : #initialization }
EJDB >> initialize [

	super initialize.
	collections := Dictionary new
]

{ #category : #private }
EJDB >> meta [
	| document |
	
	document := JBL new.
	self validateResult: (self ejdb_get_meta: document).
	^ document autoRelease
]

{ #category : #accessing }
EJDB >> removeCollectionNamed: aName [

	self validateResult: (self ejdb_remove_collection: aName)
]

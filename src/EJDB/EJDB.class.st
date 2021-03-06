"
I'm an EJDB database.
I can be opened using open: and openTruncate:
To close me is an operation that depends on the user.

I provide access to: 
- collections
- database metadata

I also provide database operations like:
- removing a collection
"
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

{ #category : #example }
EJDB class >> example [
	| db collection query |

	EJDBLibrary uniqueInstance init.

	db := EJDB openTruncate: (FileLocator imageDirectory / 'example.db') fullName.
	collection := db collectionNamed: 'parrots'.

	collection addFromJSONString: '{ "name" : "Bianca", "age" : 4 }'. 
	collection addFromJSONString: '{ "name" : "Nera", "age" : 8 }'. 

	query := collection query: '/[ "age" > 0 ]'.
	query resultsDo: [ :id :record | 
		(id printString, '->', record printString) crTrace ].

	db close
]

{ #category : #opening }
EJDB class >> open: aName [
	
	^ self open: aName mode: 0
]

{ #category : #private }
EJDB class >> open: aName mode: mode [
	| options path |

	options := EJDB_OPTS new.
	path := ExternalAddress fromString: aName.
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
EJDB class >> openTruncate: aName [
	
	^ self open: aName mode: IWKV_TRUNC
]

{ #category : #'opening/closing' }
EJDB >> close [

	self validateResult: self ejdb_close.
	self getHandle beNull
]

{ #category : #accessing }
EJDB >> collectionNamed: aName [

	^ collections 
		at: aName 
		ifAbsentPut: [ 
			(EJDBCollection newDatabase: self name: aName) ensureCollection ]
]

{ #category : #accessing }
EJDB >> collectionNames [

	^ (self meta at: #collections) 
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

{ #category : #testing }
EJDB >> isOpened [ 

	^ self getHandle notNil and: [ self getHandle isNull not ]
]

{ #category : #accessing }
EJDB >> meta [
	| document meta |
	
	document := JBL new.
	[
		self validateResult: (self ejdb_get_meta: document).
		meta := document toDocument ]
	ensure: [ 
		document destroy ].
	
	^ meta
]

{ #category : #accessing }
EJDB >> removeCollectionNamed: aName [

	self validateResult: (self ejdb_remove_collection: aName)
]

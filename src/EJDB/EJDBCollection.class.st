Class {
	#name : #EJDBCollection,
	#superclass : #Object,
	#traits : 'EJDBTLibrary',
	#classTraits : 'EJDBTLibrary classTrait',
	#instVars : [
		'database',
		'name'
	],
	#pools : [
		'EJDBConstants',
		'EJDBTypes'
	],
	#category : #EJDB
}

{ #category : #'instance creation' }
EJDBCollection class >> newDatabase: aDatabase name: aName [

	^ self basicNew 
		initializeDatabase: aDatabase name: aName;
		yourself
	
]

{ #category : #adding }
EJDBCollection >> add: aJBL [
	| idBuffer |

	idBuffer := FFIInt64 newBuffer.
	self validateResult: (self ejdb_put_new: aJBL oid: idBuffer).
	^ idBuffer signedLongAt: 1
]

{ #category : #adding }
EJDBCollection >> addFromJSONDictionary: aDictionary [
	| id record |

	record := JBL fromJSONString: (STONJSON toString: aDictionary).
	id := [ self add: record ]
	ensure: [ record destroy ].

	^ id
	

]

{ #category : #adding }
EJDBCollection >> addFromJSONString: aString [
	| id record |

	record := JBL fromJSONString: aString.
	id := [ self add: record ]
	ensure: [ record destroy ].

	^ id
	

]

{ #category : #accessing }
EJDBCollection >> at: oid [ 
	| document |
	
	document := JBL new.
	self validateResult: (self ejdb_get: oid to: document).
	^ document autoRelease
]

{ #category : #accessing }
EJDBCollection >> at: oid put: document [

	self validateResult: (self ejdb_put: document oid: oid)
]

{ #category : #accessing }
EJDBCollection >> database [

	^ database
]

{ #category : #'private primitives' }
EJDBCollection >> ejdb_del: id [

	self ffiCall: #(iwrc ejdb_del(EJDB database, const char *name, int64_t id))
]

{ #category : #'private primitives' }
EJDBCollection >> ejdb_ensure_collection [

	self ffiCall: #(iwrc ejdb_ensure_collection(EJDB database, const char *name))
]

{ #category : #'private primitives' }
EJDBCollection >> ejdb_get: id to: jblp [
	
	^ self ffiCall: #(iwrc ejdb_get(EJDB database, const char *name, int64_t id, JBL *jblp))
]

{ #category : #'private primitives' }
EJDBCollection >> ejdb_put: jbl oid: id [ 
	
	^ self ffiCall: #(iwrc ejdb_put(EJDB database, const char *name, JBL jbl, int64_t id))
]

{ #category : #'private primitives' }
EJDBCollection >> ejdb_put_new: jbl oid: oid [ 

	^ self ffiCall: #(iwrc ejdb_put_new(EJDB database, const char *name, JBL jbl, int64_t *oid))
]

{ #category : #accessing }
EJDBCollection >> ensureCollection [

	self validateResult: self ejdb_ensure_collection
]

{ #category : #initialization }
EJDBCollection >> initializeDatabase: aDatabase name: aName [

	self initialize.
	database := aDatabase.
	name := aName
]

{ #category : #accessing }
EJDBCollection >> meta [

	^ (self database meta at: #collections)
		detect: [ :each | (each at: #name) = self name ]
]

{ #category : #accessing }
EJDBCollection >> name [

	^ name
]

{ #category : #'private factory' }
EJDBCollection >> newQueryFromString: aString [

	^ JQL newCollection: self query: aString
]

{ #category : #querying }
EJDBCollection >> query: aBlockOrString [
	
	^ self queryFromString: (aBlockOrString isString 
		ifTrue: [ aBlockOrString ]
		ifFalse: [ aBlockOrString asPersistenceQuery ])
]

{ #category : #querying }
EJDBCollection >> queryAll [

	^ self queryFromString: '/*'
]

{ #category : #querying }
EJDBCollection >> queryFromString: aString [

	^ (self newQueryFromString: aString) autoRelease
]

{ #category : #removing }
EJDBCollection >> removeAll [
	"I will just remove the collection (adding a new element will re-create it"
	
	self database removeCollectionNamed: self name
]

{ #category : #removing }
EJDBCollection >> removeId: oid [

	self validateResult: (self ejdb_del: oid)
]

{ #category : #accessing }
EJDBCollection >> size [

	^ self meta at: #rnum
]

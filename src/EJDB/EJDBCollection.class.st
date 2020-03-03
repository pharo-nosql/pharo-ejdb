"
I represent a collection of EJDB and its basic operations. 
I implement basic I/O operations: add:, at:, at:put: and convenience methods that receive a JSON dictionary or/and a JSON string.
I implement also query operations: select: and detect: and a low-level query mechanism with query:
 
"
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
EJDBCollection >> at: oid putDocument: aDictionary [
	| record |

	record := JBL fromJSONString: (STONJSON toString: aDictionary).
	[ self at: oid put: record ]
	ensure: [ record destroy ]
]

{ #category : #accessing }
EJDBCollection >> database [

	^ database
]

{ #category : #enumerating }
EJDBCollection >> detect: aQueryString [

	^ (self query: aQueryString) detect
]

{ #category : #enumerating }
EJDBCollection >> detect: aQueryString ifFound: foundBlock ifNone: noneBlock [

	^ (self query: aQueryString) detectIfFound: foundBlock ifNone: noneBlock
]

{ #category : #enumerating }
EJDBCollection >> detect: aQueryString ifNone: noneBlock [

	^ (self query: aQueryString) 
		detectIfFound: [ :doc | doc ] 
		ifNone: noneBlock
]

{ #category : #enumerating }
EJDBCollection >> detectWithId: aQueryString [

	^ (self query: aQueryString) detectWithId
]

{ #category : #enumerating }
EJDBCollection >> detectWithId: aQueryString ifFound: foundBlock ifNone: noneBlock [

	^ (self query: aQueryString) 
		detectWithIdIfFound: foundBlock 
		ifNone: noneBlock
]

{ #category : #enumerating }
EJDBCollection >> detectWithId: aQueryString ifNone: noneBlock [

	^ (self query: aQueryString) 
		detectWithIdIfFound: [ :doc | doc ] 
		ifNone: noneBlock
]

{ #category : #accessing }
EJDBCollection >> documentAt: oid [
	
	^ (self at: oid) toDocument 
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
EJDBCollection >> newQuery: aString [

	^ JQL newCollection: self query: aString
]

{ #category : #querying }
EJDBCollection >> query: aString [

	^ (self newQuery: aString) autoRelease
]

{ #category : #querying }
EJDBCollection >> queryAll [

	^ self query: '/*'
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

{ #category : #enumerating }
EJDBCollection >> select: aQueryString [

	^ (self query: aQueryString) select
]

{ #category : #enumerating }
EJDBCollection >> selectAll [

	^ self queryAll select
]

{ #category : #enumerating }
EJDBCollection >> selectAllWithId [

	^ self queryAll selectWithId
]

{ #category : #accessing }
EJDBCollection >> size [

	^ self meta at: #rnum
]

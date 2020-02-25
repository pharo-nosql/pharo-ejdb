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
EJDBCollection >> addFromJSONString: aString [
	| id record |

	record := JBL fromJSONString: aString.
	id := [ self add: record ]
	ensure: [ record destroy ].

	^ id
	

]

{ #category : #accessing }
EJDBCollection >> database [

	^ database
]

{ #category : #private }
EJDBCollection >> ejdb_del: id [

	self ffiCall: #(iwrc ejdb_del(EJDB database, const char *name, int64_t id))
]

{ #category : #adding }
EJDBCollection >> ejdb_put_new: jbl oid: oid [ 

	^ self ffiCall: #(iwrc ejdb_put_new(EJDB database, const char *name, JBL jbl, int64_t *oid))
]

{ #category : #initialization }
EJDBCollection >> initializeDatabase: aDatabase name: aName [

	self initialize.
	database := aDatabase.
	name := aName
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

"
I'm a list answered by executing a query.
I keep a pointer to my first document.

"
Class {
	#name : #'EJDB_LIST',
	#superclass : #EJDBStructure,
	#classVars : [
		'OFFSET_DB',
		'OFFSET_FIRST',
		'OFFSET_POOL',
		'OFFSET_Q'
	],
	#category : #EJDB
}

{ #category : #private }
EJDB_LIST class >> ejdb_list3: db collection: coll query: query limit: limit log: log list: listp [

	^ self ffiCall: #(iwrc ejdb_list3(
		EJDB db, 
		const char *coll, 
		const char *query, 
		int64_t limit,
		IWXSTR *log, 
		EJDB_LIST *listp))
]

{ #category : #private }
EJDB_LIST class >> ejdb_list_destroy: listp [

	self ffiCall: #(void ejdb_list_destroy(EJDB_LIST *listp))
]

{ #category : #'field definition' }
EJDB_LIST class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	EJDB db;
	JQL q;
	EJDB_DOC *first;
	IWPOOL *pool; 
	)
]

{ #category : #'instance creation' }
EJDB_LIST class >> newList: anEJDBCollection query: aString [
	| list log |
	
	log := IWXSTR null.
	list := ExternalAddress null.
	self validateResult: (self 
		ejdb_list3: anEJDBCollection database 
		collection: anEJDBCollection name
		query: aString
		limit: 0
		log: log
		list: list).
	
	^ self fromHandle: list
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> db [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DB) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> db: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DB put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> first [
	"This method was automatically generated"
	^EJDB_DOC fromHandle: (handle pointerAt: OFFSET_FIRST)
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> first: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_FIRST put: anObject getHandle.
]

{ #category : #finalization }
EJDB_LIST >> free [

	(handle notNil and: [ handle isExternalAddress ]) ifFalse: [ ^ self ].
	IWPOOL iwpool_destroy: self pool.
	self class destroy: self.
	handle := nil
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> pool [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_POOL) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> pool: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_POOL put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> q [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_Q) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> q: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_Q put: anObject getHandle.
]

{ #category : #enumerating }
EJDB_LIST >> results [
	
	^ Array streamContents: [ :stream |
		self resultsDo: [ :eachId :eachDoc |
			stream nextPut: eachDoc ] ]
]

{ #category : #enumerating }
EJDB_LIST >> resultsDo: aBlock [
	| current |
	
	self isNull ifTrue: [ ^ self ].
	current := self first.
	[ current isNull not and: [ current id ~= 0 ] ] 
	whileTrue: [ 
		aBlock 
			value: current id 
			value: current raw toDocument.
		current := current next ]
]

{ #category : #enumerating }
EJDB_LIST >> resultsWithId [
	
	^ Array streamContents: [ :stream |
		self resultsDo: [ :eachId :eachDoc |
			stream nextPut: eachId -> eachDoc ] ]
]

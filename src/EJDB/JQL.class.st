"
I represent a query.
See jql.h
"
Class {
	#name : #JQL,
	#superclass : #EJDBExternalPointer,
	#instVars : [
		'collection'
	],
	#category : #EJDB
}

{ #category : #finalization }
JQL class >> finalizeResourceData: handle [ 

	(handle isNil or: [ handle isNull ]) ifTrue: [ ^ self ].
	self jql_destroy: handle.
	handle beNull
]

{ #category : #private }
JQL class >> jql_create: qptr collection: coll query: query [
	
	^ self ffiCall: #(iwrc jql_create(JQL *qptr, const char *coll, const char *query))
]

{ #category : #private }
JQL class >> jql_destroy: handle [
 
	self ffiCall: #(void jql_destroy("JQL *q"void *handle))
]

{ #category : #'instance creation' }
JQL class >> newCollection: anEJDBCollection query: aString [
	| instance |
	
	instance := self new.
	instance collection: anEJDBCollection.
	self validateResult: (self 
		jql_create: instance 
		collection: anEJDBCollection name
		query: aString).
	^ instance
]

{ #category : #accessing }
JQL >> collection [
	^ collection
]

{ #category : #accessing }
JQL >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
JQL >> database [

	^ self collection database
]

{ #category : #accessing }
JQL >> destroy [

	self class jql_destroy: self getHandle.
	self getHandle beNull
]

{ #category : #enumerating }
JQL >> detect [
	"Answers all elements in query. 
	 Is like #results, but it uses ejdb_list instead (to not use callbacks)"

	self 
		listResultsLimit: 1 
		do: [ :eachId :eachDoc | ^ eachDoc ].
	
	^ nil
]

{ #category : #enumerating }
JQL >> detectWithId [
	"Answers all elements in query. 
	 Is like #results, but it uses ejdb_list instead (to not use callbacks)"

	self 
		listResultsLimit: 1
		do: [ :eachId :eachDoc | ^ eachId -> eachDoc ].

	^ nil
]

{ #category : #'private primitives' }
JQL >> ejdb_exec: ux [

	^ self ffiCall: #(iwrc ejdb_exec(EJDB_EXEC *ux))
]

{ #category : #'private primitives' }
JQL >> ejdb_list4: db limit: limit log: log list: listp [ 

	^ self ffiCall: #(iwrc ejdb_list4(
		EJDB db, 
		self, 
		int64_t limit, 
		IWXSTR *log, 
		"EJDB_LIST *"void *listp))
]

{ #category : #'private primitives' }
JQL >> ejdb_list: db first: first limit: limit pool: pool [  

	^ self ffiCall: #(iwrc ejdb_list(
		EJDB db, 
		self, 
		"EJDB_DOC *"void **first, 
		int64_t limit, 
		IWPOOL *pool))
]

{ #category : #private }
JQL >> listResultsDo: aBlock [
	
	self listResultsLimit: 0 do: aBlock
]

{ #category : #private }
JQL >> listResultsLimit: limit do: aBlock [
	"Answers all elements in query. 
	 Is like #results, but it uses ejdb_list instead (to not use callbacks)"
	| firstHandle first pool |
	
	firstHandle := ExternalAddress new.
	pool := IWPOOL new.
	[
		self validateResult: (self 
			ejdb_list: self database 
			first: firstHandle 
			limit: limit 
			pool: pool).
		
		first := EJDB_DOC fromHandle: firstHandle.
		[ first isNull ] whileFalse: [ 
			aBlock 
				value: first id
				value: first raw toJSONDictionary.
			first := first next ] ]
	ensure: [ 
		pool destroy ]
]

{ #category : #enumerating }
JQL >> results [
	
	^ Array streamContents: [ :stream |
		self resultsDo: [ :eachId :eachDoc |
			stream nextPut: eachDoc ] ]
]

{ #category : #enumerating }
JQL >> resultsDo: aBlock [
	"traverses the query cursor calling a block with the result. 
	 aBlock receives two arguments: 
		- id
		- record"
	| ux |

	ux := EJDB_EXEC new
		db: self database;
		q: self;
		visitor: (EJDBCallback 
			signature: #(iwrc ("struct _EJDB_EXEC *"void *ctx, "EJDB_DOC" void *doc, int64_t *step))
			block: [ :ctx :docHandle :step | | doc |
				doc := EJDB_DOC fromHandle: docHandle.
				aBlock 
					value: doc id 
					value: doc raw toJSONDictionary.
				0 ]);
		yourself.
		
	self validateResult: (self ejdb_exec: ux)
]

{ #category : #enumerating }
JQL >> resultsWithId [
	
	^ Array streamContents: [ :stream |
		self resultsDo: [ :eachId :eachDoc |
			stream nextPut: eachId -> eachDoc ] ]
]

{ #category : #enumerating }
JQL >> select [
	"Answers all elements in query. 
	 Is like #results, but it uses ejdb_list instead (to not use callbacks)"
	
	^ Array streamContents: [ :stream | 
		self listResultsDo: [ :eachId :eachDoc |
			stream nextPut: eachDoc ] ]
	
]

{ #category : #enumerating }
JQL >> selectWithId [
	"Answers all elements in query. 
	 Is like #results, but it uses ejdb_list instead (to not use callbacks)"
	
	^ Array streamContents: [ :stream | 
		self listResultsDo: [ :eachId :eachDoc |
			stream nextPut: eachId -> eachDoc ] ]
]

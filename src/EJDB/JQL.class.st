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

{ #category : #private }
JQL >> ejdb_exec: ux [

	^ self ffiCall: #(iwrc ejdb_exec(EJDB_EXEC *ux))
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
				aBlock value: doc id value: doc raw.
				0 ]);
		yourself.
		
	self validateResult: (self ejdb_exec: ux)
]

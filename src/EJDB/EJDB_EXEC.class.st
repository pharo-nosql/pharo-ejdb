Class {
	#name : #'EJDB_EXEC',
	#superclass : #EJDBStructure,
	#instVars : [
		'visitor'
	],
	#classVars : [
		'OFFSET_CNT',
		'OFFSET_DB',
		'OFFSET_LIMIT',
		'OFFSET_LOG',
		'OFFSET_OPAQUE',
		'OFFSET_POOL',
		'OFFSET_Q',
		'OFFSET_SKIP',
		'OFFSET_VISITOR'
	],
	#category : #EJDB
}

{ #category : #'field definition' }
EJDB_EXEC class >> fieldsDesc [
	"self rebuildFieldAccessors"
	
	^ #(
	EJDB db;
	JQL q;
	FFICallback visitor; "iwrc(*EJDB_EXEC_VISITOR)(struct _EJDB_EXEC *ctx, EJDB_DOC doc, int64_t *step)"
	void *opaque;
	int64_t skip;
	int64_t limit;
	int64_t cnt;
	IWXSTR *log;
	IWPOOL *pool;
	)
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> cnt [
	"This method was automatically generated"
	^handle signedLongLongAt: OFFSET_CNT
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> cnt: anObject [
	"This method was automatically generated"
	handle signedLongLongAt: OFFSET_CNT put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> db [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_DB) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> db: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_DB put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> limit [
	"This method was automatically generated"
	^handle signedLongLongAt: OFFSET_LIMIT
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> limit: anObject [
	"This method was automatically generated"
	handle signedLongLongAt: OFFSET_LIMIT put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> log [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LOG) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> log: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LOG put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> opaque [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_OPAQUE) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> opaque: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_OPAQUE put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> pool [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_POOL) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> pool: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_POOL put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> q [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_Q) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> q: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_Q put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> skip [
	"This method was automatically generated"
	^handle signedLongLongAt: OFFSET_SKIP
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> skip: anObject [
	"This method was automatically generated"
	handle signedLongLongAt: OFFSET_SKIP put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> visitor [
	"This method was automatically generated"
	^ visitor ifNil: [ 
		visitor := FFICallback forAddress: ((handle pointerAt: OFFSET_VISITOR) asInteger) ]
]

{ #category : #'accessing structure variables' }
EJDB_EXEC >> visitor: aCallback [

	visitor := aCallback.
	handle 
		pointerAt: OFFSET_VISITOR
		put: (aCallback 
			ifNotNil: [ aCallback thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

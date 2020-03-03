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

{ #category : #'field definition' }
EJDB_LIST class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	EJDB db;
	JQL q;
	EJDB_DOC first;
	IWPOOL *pool; 
	)
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
	^ EJDB_DOC fromHandle: (handle referenceStructAt: OFFSET_FIRST length: EJDB_DOC byteSize)
]

{ #category : #'accessing structure variables' }
EJDB_LIST >> first: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_FIRST put: anObject getHandle length: EJDB_DOC byteSize
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

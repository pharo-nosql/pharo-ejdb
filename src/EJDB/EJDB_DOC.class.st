Class {
	#name : #'EJDB_DOC',
	#superclass : #EJDBStructure,
	#instVars : [
		'raw'
	],
	#classVars : [
		'OFFSET_ID',
		'OFFSET_NEXT',
		'OFFSET_NODE',
		'OFFSET_PREV',
		'OFFSET_RAW'
	],
	#category : #EJDB
}

{ #category : #'field definition' }
EJDB_DOC class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	int64_t id;
	JBL raw;
	"JBL_NODE"void *node;
	EJDB_DOC *next;
	EJDB_DOC *prev;
	)
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> id [
	"This method was automatically generated"
	^handle signedLongLongAt: OFFSET_ID
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> id: anObject [
	"This method was automatically generated"
	handle signedLongLongAt: OFFSET_ID put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> next [
	"This method was automatically generated"
	^EJDB_DOC fromHandle: (handle pointerAt: OFFSET_NEXT)
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> next: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_NEXT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> node [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_NODE) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> node: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_NODE put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> prev [
	"This method was automatically generated"
	^EJDB_DOC fromHandle: (handle pointerAt: OFFSET_PREV)
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> prev: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PREV put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> raw [
	"This method was automatically generated"
	^ raw ifNil: [ 
		raw := JBL fromHandle: (handle pointerAt: OFFSET_RAW) ]
]

{ #category : #'accessing structure variables' }
EJDB_DOC >> raw: anObject [
	"This method was automatically generated"
	raw := anObject.
	handle pointerAt: OFFSET_RAW put: anObject getHandle.
]

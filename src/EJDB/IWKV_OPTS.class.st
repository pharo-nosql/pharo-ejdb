Class {
	#name : #'IWKV_OPTS',
	#superclass : #EJDBStructure,
	#classVars : [
		'OFFSET_FILE_LOCK_FAIL_FAST',
		'OFFSET_OFLAGS',
		'OFFSET_PATH',
		'OFFSET_RANDOM_SEED',
		'OFFSET_WAL'
	],
	#category : #EJDB
}

{ #category : #'field definition' }
IWKV_OPTS class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	char *path;
	uint32_t random_seed;
	iwkv_openflags oflags;
	bool file_lock_fail_fast;
	IWKV_WAL_OPTS wal;   	
	)
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> file_lock_fail_fast [
	"This method was automatically generated"
	^handle booleanAt: OFFSET_FILE_LOCK_FAIL_FAST
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> file_lock_fail_fast: anObject [
	"This method was automatically generated"
	handle booleanAt: OFFSET_FILE_LOCK_FAIL_FAST put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> oflags [
	"This method was automatically generated"
	^handle unsignedByteAt: OFFSET_OFLAGS
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> oflags: anObject [
	"This method was automatically generated"
	handle unsignedByteAt: OFFSET_OFLAGS put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> path [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PATH) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> path: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PATH put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> random_seed [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_RANDOM_SEED
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> random_seed: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_RANDOM_SEED put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> wal [
	"This method was automatically generated"
	^ IWKV_WAL_OPTS fromHandle: (handle referenceStructAt: OFFSET_WAL length: IWKV_WAL_OPTS byteSize)
]

{ #category : #'accessing structure variables' }
IWKV_OPTS >> wal: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_WAL put: anObject getHandle length: IWKV_WAL_OPTS byteSize
]

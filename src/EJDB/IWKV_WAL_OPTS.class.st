"
I define how the wal works. 
I am not used in current bindings session, but definition is needed for IWKV_OPTS
"
Class {
	#name : #'IWKV_WAL_OPTS',
	#superclass : #EJDBStructure,
	#instVars : [
		'wal_lock_interceptor'
	],
	#classVars : [
		'OFFSET_CHECKPOINT_BUFFER_SZ',
		'OFFSET_CHECKPOINT_TIMEOUT_SEC',
		'OFFSET_CHECK_CRC_ON_CHECKPOINT',
		'OFFSET_ENABLED',
		'OFFSET_SAVEPOINT_TIMEOUT_SEC',
		'OFFSET_WAL_BUFFER_SZ',
		'OFFSET_WAL_LOCK_INTERCEPTOR',
		'OFFSET_WAL_LOCK_INTERCEPTOR_OPAQUE'
	],
	#category : #EJDB
}

{ #category : #'field definition' }
IWKV_WAL_OPTS class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	bool enabled;
	bool check_crc_on_checkpoint;
	uint32_t savepoint_timeout_sec;
	uint32_t checkpoint_timeout_sec
	size_t wal_buffer_sz;
	uint64_t checkpoint_buffer_sz;
	FFICallback wal_lock_interceptor; "iwrc(*wal_lock_interceptor)(bool, void *);"
	void *wal_lock_interceptor_opaque;
	)
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> check_crc_on_checkpoint [
	"This method was automatically generated"
	^handle booleanAt: OFFSET_CHECK_CRC_ON_CHECKPOINT
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> check_crc_on_checkpoint: anObject [
	"This method was automatically generated"
	handle booleanAt: OFFSET_CHECK_CRC_ON_CHECKPOINT put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> checkpoint_buffer_sz [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_CHECKPOINT_BUFFER_SZ
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> checkpoint_buffer_sz: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_CHECKPOINT_BUFFER_SZ put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> checkpoint_timeout_sec [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_CHECKPOINT_TIMEOUT_SEC
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> checkpoint_timeout_sec: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_CHECKPOINT_TIMEOUT_SEC put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> enabled [
	"This method was automatically generated"
	^handle booleanAt: OFFSET_ENABLED
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> enabled: anObject [
	"This method was automatically generated"
	handle booleanAt: OFFSET_ENABLED put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> savepoint_timeout_sec [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_SAVEPOINT_TIMEOUT_SEC
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> savepoint_timeout_sec: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_SAVEPOINT_TIMEOUT_SEC put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> wal_buffer_sz [
	"This method was automatically generated"
	^handle platformSizeTAt: OFFSET_WAL_BUFFER_SZ
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> wal_buffer_sz: anObject [
	"This method was automatically generated"
	^handle platformSizeTAt: OFFSET_WAL_BUFFER_SZ put: anObject
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> wal_lock_interceptor [
	"This method was automatically generated"
	
	^ wal_lock_interceptor ifNotNil: [ 
		| cbHandle |
		cbHandle := handle pointerAt: OFFSET_WAL_LOCK_INTERCEPTOR.
		wal_lock_interceptor := cbHandle ifNotNil: [ 
			FFICallback forAddress: cbHandle asInteger ] ]
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> wal_lock_interceptor: aCallback [
	"This method was automatically generated"
	
	wal_lock_interceptor := aCallback.
	handle 
		pointerAt: OFFSET_WAL_LOCK_INTERCEPTOR
		put: (aCallback 
			ifNotNil: [ aCallback thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> wal_lock_interceptor_opaque [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_WAL_LOCK_INTERCEPTOR_OPAQUE) type: ExternalType void asPointerType
]

{ #category : #'accessing structure variables' }
IWKV_WAL_OPTS >> wal_lock_interceptor_opaque: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_WAL_LOCK_INTERCEPTOR_OPAQUE put: anObject getHandle.
]

"
I define options to open a database.
For now we are just interested in the kv section, which points to an IWKV_OPTS structure and define the database physic location itself.
"
Class {
	#name : #'EJDB_OPTS',
	#superclass : #EJDBStructure,
	#classVars : [
		'OFFSET_DOCUMENT_BUFFER_SZ',
		'OFFSET_HTTP',
		'OFFSET_KV',
		'OFFSET_NO_WAL',
		'OFFSET_SORT_BUFFER_SZ'
	],
	#category : #EJDB
}

{ #category : #'field definition' }
EJDB_OPTS class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	IWKV_OPTS kv;
	EJDB_HTTP http;
	bool no_wal;
	uint32_t sort_buffer_sz;
	uint32_t document_buffer_sz;
	)
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> document_buffer_sz [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DOCUMENT_BUFFER_SZ
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> document_buffer_sz: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DOCUMENT_BUFFER_SZ put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> http [
	"This method was automatically generated"
	^ EJDB_HTTP fromHandle: (handle referenceStructAt: OFFSET_HTTP length: EJDB_HTTP byteSize)
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> http: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_HTTP put: anObject getHandle length: EJDB_HTTP byteSize
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> kv [
	"This method was automatically generated"
	^ IWKV_OPTS fromHandle: (handle referenceStructAt: OFFSET_KV length: IWKV_OPTS byteSize)
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> kv: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_KV put: anObject getHandle length: IWKV_OPTS byteSize
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> no_wal [
	"This method was automatically generated"
	^handle booleanAt: OFFSET_NO_WAL
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> no_wal: anObject [
	"This method was automatically generated"
	handle booleanAt: OFFSET_NO_WAL put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> sort_buffer_sz [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_SORT_BUFFER_SZ
]

{ #category : #'accessing structure variables' }
EJDB_OPTS >> sort_buffer_sz: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_SORT_BUFFER_SZ put: anObject
]

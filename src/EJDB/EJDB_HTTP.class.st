Class {
	#name : #'EJDB_HTTP',
	#superclass : #EJDBStructure,
	#classVars : [
		'OFFSET_ACCESS_TOKEN',
		'OFFSET_ACCESS_TOKEN_LEN',
		'OFFSET_BIND',
		'OFFSET_BLOCKING',
		'OFFSET_ENABLED',
		'OFFSET_MAX_BODY_SIZE',
		'OFFSET_PORT',
		'OFFSET_READ_ANON'
	],
	#category : #EJDB
}

{ #category : #'field definition' }
EJDB_HTTP class >> fieldsDesc [
	"self rebuildFieldAccessors"

	^ #(
	bool enabled;
	int port;
	char *bind;
	char *access_token;
	size_t access_token_len;
	bool blocking;
	bool read_anon;
	size_t max_body_size;	
	)
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> access_token [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_ACCESS_TOKEN) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> access_token: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_ACCESS_TOKEN put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> access_token_len [
	"This method was automatically generated"
	^handle platformSizeTAt: OFFSET_ACCESS_TOKEN_LEN
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> access_token_len: anObject [
	"This method was automatically generated"
	^handle platformSizeTAt: OFFSET_ACCESS_TOKEN_LEN put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> bind [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_BIND) type: ExternalType char asPointerType
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> bind: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_BIND put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> blocking [
	"This method was automatically generated"
	^handle booleanAt: OFFSET_BLOCKING
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> blocking: anObject [
	"This method was automatically generated"
	handle booleanAt: OFFSET_BLOCKING put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> enabled [
	"This method was automatically generated"
	^handle booleanAt: OFFSET_ENABLED
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> enabled: anObject [
	"This method was automatically generated"
	handle booleanAt: OFFSET_ENABLED put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> max_body_size [
	"This method was automatically generated"
	^handle platformSizeTAt: OFFSET_MAX_BODY_SIZE
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> max_body_size: anObject [
	"This method was automatically generated"
	^handle platformSizeTAt: OFFSET_MAX_BODY_SIZE put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> port [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_PORT
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> port: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_PORT put: anObject
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> read_anon [
	"This method was automatically generated"
	^handle booleanAt: OFFSET_READ_ANON
]

{ #category : #'accessing structure variables' }
EJDB_HTTP >> read_anon: anObject [
	"This method was automatically generated"
	handle booleanAt: OFFSET_READ_ANON put: anObject
]

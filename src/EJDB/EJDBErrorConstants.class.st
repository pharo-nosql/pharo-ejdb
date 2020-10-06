"
All EJDB error codes along with its description. 
This will be used in `EJDBLibrary>>#validateResult:` to produce an output a bit more comprensible.
"
Class {
	#name : #EJDBErrorConstants,
	#superclass : #SharedPool,
	#instVars : [
		'value',
		'message'
	],
	#classVars : [
		'EJDB_ERROR_COLLECTION_NOT_FOUND',
		'EJDB_ERROR_INVALID_COLLECTION_INDEX_META',
		'EJDB_ERROR_INVALID_COLLECTION_META',
		'EJDB_ERROR_INVALID_COLLECTION_NAME',
		'EJDB_ERROR_INVALID_INDEX_MODE',
		'EJDB_ERROR_MISMATCHED_INDEX_UNIQUENESS_MODE',
		'EJDB_ERROR_PATCH_JSON_NOT_OBJECT',
		'EJDB_ERROR_TARGET_COLLECTION_EXISTS',
		'EJDB_ERROR_UNIQUE_INDEX_CONSTRAINT_VIOLATED',
		'IWFS_ERROR_FSM_SEGMENTATION',
		'IWFS_ERROR_INVALID_BLOCK_SIZE',
		'IWFS_ERROR_INVALID_FILEMETA',
		'IWFS_ERROR_MAXOFF',
		'IWFS_ERROR_MMAP_OVERLAP',
		'IWFS_ERROR_NOT_MMAPED',
		'IWFS_ERROR_NO_FREE_SPACE',
		'IWFS_ERROR_PLATFORM_PAGE',
		'IWFS_ERROR_RANGE_NOT_ALIGNED',
		'IWFS_ERROR_RESIZE_FAIL',
		'IWFS_ERROR_RESIZE_POLICY_FAIL',
		'IWKV_ERROR_BACKUP_IN_PROGRESS',
		'IWKV_ERROR_CORRUPTED',
		'IWKV_ERROR_CORRUPTED_WAL_FILE',
		'IWKV_ERROR_DUP_VALUE_SIZE',
		'IWKV_ERROR_INCOMPATIBLE_DB_FORMAT',
		'IWKV_ERROR_INCOMPATIBLE_DB_MODE',
		'IWKV_ERROR_KEY_EXISTS',
		'IWKV_ERROR_KEY_NUM_VALUE_SIZE',
		'IWKV_ERROR_MAXKVSZ',
		'IWKV_ERROR_NOTFOUND',
		'IWKV_ERROR_VALUE_CANNOT_BE_INCREMENTED',
		'IWKV_ERROR_WAL_MODE_REQUIRED',
		'IW_ERROR_ALLOC',
		'IW_ERROR_ALREADY_OPENED',
		'IW_ERROR_ASSERTION',
		'IW_ERROR_ERRNO',
		'IW_ERROR_FAIL',
		'IW_ERROR_FALSE',
		'IW_ERROR_INVALID_ARGS',
		'IW_ERROR_INVALID_HANDLE',
		'IW_ERROR_INVALID_STATE',
		'IW_ERROR_INVALID_VALUE',
		'IW_ERROR_IO_ERRNO',
		'IW_ERROR_NOT_ALIGNED',
		'IW_ERROR_NOT_EXISTS',
		'IW_ERROR_NOT_IMPLEMENTED',
		'IW_ERROR_OUT_OF_BOUNDS',
		'IW_ERROR_OVERFLOW',
		'IW_ERROR_READONLY',
		'IW_ERROR_START',
		'IW_ERROR_THREADING',
		'IW_ERROR_THREADING_ERRNO',
		'JBL_ERROR_CREATION',
		'JBL_ERROR_INVALID',
		'JBL_ERROR_INVALID_BUFFER',
		'JBL_ERROR_JSON_POINTER',
		'JBL_ERROR_MAX_NESTING_LEVEL_EXCEEDED',
		'JBL_ERROR_NOT_AN_OBJECT',
		'JBL_ERROR_PARSE_INVALID_CODEPOINT',
		'JBL_ERROR_PARSE_INVALID_UTF8',
		'JBL_ERROR_PARSE_JSON',
		'JBL_ERROR_PARSE_UNQUOTED_STRING',
		'JBL_ERROR_PATCH_INVALID',
		'JBL_ERROR_PATCH_INVALID_ARRAY_INDEX',
		'JBL_ERROR_PATCH_INVALID_OP',
		'JBL_ERROR_PATCH_INVALID_VALUE',
		'JBL_ERROR_PATCH_NOVALUE',
		'JBL_ERROR_PATCH_TARGET_INVALID',
		'JBL_ERROR_PATCH_TEST_FAILED',
		'JBL_ERROR_PATH_NOTFOUND',
		'JBL_ERROR_TYPE_MISMATCHED',
		'JBR_ERROR_HTTP_LISTEN',
		'JBR_ERROR_PORT_INVALID',
		'JBR_ERROR_SEND_RESPONSE',
		'JBR_ERROR_WS_ACCESS_DENIED',
		'JBR_ERROR_WS_INVALID_MESSAGE',
		'JBR_ERROR_WS_UPGRADE',
		'JQL_ERROR_INVALID_PLACEHOLDER',
		'JQL_ERROR_INVALID_PLACEHOLDER_VALUE_TYPE',
		'JQL_ERROR_LIMIT_ALREADY_SET',
		'JQL_ERROR_NO_COLLECTION',
		'JQL_ERROR_ORDERBY_MAX_LIMIT',
		'JQL_ERROR_QUERY_PARSE',
		'JQL_ERROR_REGEXP_CHARSET',
		'JQL_ERROR_REGEXP_ENGINE',
		'JQL_ERROR_REGEXP_INVALID',
		'JQL_ERROR_REGEXP_SUBEXP',
		'JQL_ERROR_REGEXP_SUBMATCH',
		'JQL_ERROR_SKIP_ALREADY_SET',
		'JQL_ERROR_UNSET_PLACEHOLDER'
	],
	#category : #EJDB
}

{ #category : #accessing }
EJDBErrorConstants class >> at: anItem [

	^ self classPool at: anItem ifAbsent: [ nil ]
]

{ #category : #accessing }
EJDBErrorConstants class >> errorStart [
	
	^ 70000
]

{ #category : #'instance creation' }
EJDBErrorConstants class >> fromInteger: anIntegerValue [
	| theItem |

	theItem := self itemAt: anIntegerValue.
	theItem ifNil: [ self error: 'Invalid value for ' , self name , ' enumeration' ].
	^ self at: theItem
]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initialize [

	self initializeIWLog.
	self initializeJQL.
	self initializeEJDB.
	self initializeJBR.
	self initializeJBL.
	self initializeIWKV.
	self initializeIWFS.
	self initializeIWFSM
]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initializeEJDB [
	| _EJDB_ERROR_START |

	_EJDB_ERROR_START := (self errorStart + 15000).
	EJDB_ERROR_INVALID_COLLECTION_NAME := self newValue: _EJDB_ERROR_START + 1 message: 'Invalid collection name'.
	EJDB_ERROR_INVALID_COLLECTION_META := self newValue: _EJDB_ERROR_START + 2 message: 'Invalid collection metadata'.
	EJDB_ERROR_INVALID_COLLECTION_INDEX_META := self newValue: _EJDB_ERROR_START + 3 message: 'Invalid collection index metadata'.
	EJDB_ERROR_INVALID_INDEX_MODE := self newValue: _EJDB_ERROR_START + 4 message: 'Invalid index mode specified'.
	EJDB_ERROR_MISMATCHED_INDEX_UNIQUENESS_MODE := self newValue: _EJDB_ERROR_START + 5 message: 'Index exists but mismatched uniqueness constraint'.
	EJDB_ERROR_UNIQUE_INDEX_CONSTRAINT_VIOLATED := self newValue: _EJDB_ERROR_START + 6 message: 'Unique index constraint violated'.
	EJDB_ERROR_COLLECTION_NOT_FOUND := self newValue: _EJDB_ERROR_START + 7 message: 'Collection not found'.
	EJDB_ERROR_TARGET_COLLECTION_EXISTS := self newValue: _EJDB_ERROR_START + 8 message: 'Target collection exists'.
	EJDB_ERROR_PATCH_JSON_NOT_OBJECT := self newValue: _EJDB_ERROR_START + 9 message: 'Patch JSON must be an object (map)'
]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initializeIWFS [
	| _IWFS_EXT_ERROR_START |
	
	_IWFS_EXT_ERROR_START := (self errorStart + 3000).
	IWFS_ERROR_MMAP_OVERLAP := self newValue: _IWFS_EXT_ERROR_START + 1 message: 'Region is mmaped already,mmaping overlaps'.
	IWFS_ERROR_NOT_MMAPED := self newValue: _IWFS_EXT_ERROR_START + 2 message: 'Region is not mmaped'.
	IWFS_ERROR_RESIZE_POLICY_FAIL := self newValue: _IWFS_EXT_ERROR_START + 3 message: 'Invalid result of resize policy function.'.
	IWFS_ERROR_MAXOFF := self newValue: _IWFS_EXT_ERROR_START + 4 message: 'Maximum file offset reached.'.
]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initializeIWFSM [
	| _IWFS_FSM_ERROR_START |
	
	_IWFS_FSM_ERROR_START := (self errorStart + 4000).
	IWFS_ERROR_NO_FREE_SPACE := self newValue: _IWFS_FSM_ERROR_START + 1 message: 'No free space.'.
	IWFS_ERROR_INVALID_BLOCK_SIZE := self newValue: _IWFS_FSM_ERROR_START + 2 message: 'Invalid block size specified'.
	IWFS_ERROR_RANGE_NOT_ALIGNED := self newValue: _IWFS_FSM_ERROR_START + 3 message: 'Specified range/offset is not aligned with page/block'.
	IWFS_ERROR_FSM_SEGMENTATION := self newValue: _IWFS_FSM_ERROR_START + 4 message: 'Free-space map segmentation error'.
	IWFS_ERROR_INVALID_FILEMETA := self newValue: _IWFS_FSM_ERROR_START + 5 message: 'Invalid file-metadata'.
	IWFS_ERROR_PLATFORM_PAGE := self newValue: _IWFS_FSM_ERROR_START + 6 message: 'Platform page size incopatibility,data migration required.'.
	IWFS_ERROR_RESIZE_FAIL := self newValue: _IWFS_FSM_ERROR_START + 7 message: 'Failed to resize file'.
]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initializeIWKV [
	| _IWKV_ERROR_START |
	
	_IWKV_ERROR_START := (self errorStart + 5000).
	IWKV_ERROR_NOTFOUND := self newValue: _IWKV_ERROR_START + 1 message: 'Key not found (IWKV_ERROR_NOTFOUND)'.
	IWKV_ERROR_KEY_EXISTS := self newValue: _IWKV_ERROR_START + 2 message: 'Key already exists (IWKV_ERROR_KEY_EXISTS)'.
	IWKV_ERROR_MAXKVSZ := self newValue: _IWKV_ERROR_START + 3 message: 'Size of Key+value must be not greater than 0xfffffff bytes (IWKV_ERROR_MAXKVSZ)'.
	IWKV_ERROR_CORRUPTED := self newValue: _IWKV_ERROR_START + 4 message: 'Database file invalid or corrupted (IWKV_ERROR_CORRUPTED)'.
	IWKV_ERROR_DUP_VALUE_SIZE := self newValue: _IWKV_ERROR_START + 5 message: 'Value size is not compatible for insertion into sorted values array (IWKV_ERROR_DUP_VALUE_SIZE)'.
	IWKV_ERROR_KEY_NUM_VALUE_SIZE := self newValue: _IWKV_ERROR_START + 6 message: 'Given key is not compatible to storage as number (IWKV_ERROR_KEY_NUM_VALUE_SIZE) '.
	IWKV_ERROR_INCOMPATIBLE_DB_MODE := self newValue: _IWKV_ERROR_START + 7 message: 'Incorpatible database open mode (IWKV_ERROR_INCOMPATIBLE_DB_MODE)'.
	IWKV_ERROR_INCOMPATIBLE_DB_FORMAT := self newValue: _IWKV_ERROR_START + 8 message: 'Incompatible database format version,please migrate database data (IWKV_ERROR_INCOMPATIBLE_DB_FORMAT)'.
	IWKV_ERROR_CORRUPTED_WAL_FILE := self newValue: _IWKV_ERROR_START + 9 message: 'Corrupted WAL file (IWKV_ERROR_CORRUPTED_WAL_FILE)'.
	IWKV_ERROR_VALUE_CANNOT_BE_INCREMENTED := self newValue: _IWKV_ERROR_START + 10 message: 'Stored value cannot be incremented/descremented (IWKV_ERROR_VALUE_CANNOT_BE_INCREMENTED)'.
	IWKV_ERROR_WAL_MODE_REQUIRED := self newValue: _IWKV_ERROR_START + 11 message: 'Operation requires WAL enabled database. (IWKV_ERROR_WAL_MODE_REQUIRED)'.
	IWKV_ERROR_BACKUP_IN_PROGRESS := self newValue: _IWKV_ERROR_START + 12 message: 'Backup operation in progress. (IWKV_ERROR_BACKUP_IN_PROGRESS)'.
]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initializeIWLog [
	| _IW_ERROR_START |

	_IW_ERROR_START := self errorStart.
	IW_ERROR_FAIL 					:= self newValue: _IW_ERROR_START + 0 message: 'Unspecified error.'.
	IW_ERROR_ERRNO 					:= self newValue: _IW_ERROR_START + 1 message: 'Error with expected errno status set.'.
	IW_ERROR_IO_ERRNO 				:= self newValue: _IW_ERROR_START + 2 message: 'IO error with expected errno status set.'.
	IW_ERROR_NOT_EXISTS 			:= self newValue: _IW_ERROR_START + 3 message: 'Resource is not exists.'.
	IW_ERROR_READONLY 				:= self newValue: _IW_ERROR_START + 4 message: 'Resource is readonly.'.
	IW_ERROR_ALREADY_OPENED 		:= self newValue: _IW_ERROR_START + 5 message: 'Resource is already opened.'.
	IW_ERROR_THREADING 			:= self newValue: _IW_ERROR_START + 6 message: 'Threading error.'.
	IW_ERROR_THREADING_ERRNO 	:= self newValue: _IW_ERROR_START + 7 message: 'Threading error with errno status set.'.
	IW_ERROR_ASSERTION 			:= self newValue: _IW_ERROR_START + 8 message: 'Generic assertion error.'.
	IW_ERROR_INVALID_HANDLE 		:= self newValue: _IW_ERROR_START + 9 message: 'Invalid HANDLE value.'.
	IW_ERROR_OUT_OF_BOUNDS 		:= self newValue: _IW_ERROR_START + 10 message: 'Invalid bounds specified.'.
	IW_ERROR_NOT_IMPLEMENTED 	:= self newValue: _IW_ERROR_START + 11  message: 'Method is not implemented.'.
	IW_ERROR_ALLOC 					:= self newValue: _IW_ERROR_START + 12 message: 'Memory allocation failed.'.
	IW_ERROR_INVALID_STATE 		:= self newValue: _IW_ERROR_START + 13 message: 'Illegal state error.'.
	IW_ERROR_NOT_ALIGNED 			:= self newValue: _IW_ERROR_START + 14 message: 'Argument is not aligned properly.'.
	IW_ERROR_FALSE 					:= self newValue: _IW_ERROR_START + 15 message: 'Request rejection/false response.'.
	IW_ERROR_INVALID_ARGS 		:= self newValue: _IW_ERROR_START + 16 message: 'Invalid function arguments.'.
	IW_ERROR_OVERFLOW 				:= self newValue: _IW_ERROR_START + 17 message: 'Overflow.'.
	IW_ERROR_INVALID_VALUE 		:= self newValue: _IW_ERROR_START + 18 message: 'Invalid value.'.

]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initializeJBL [
	| _JBL_ERROR_START |

	_JBL_ERROR_START := (self errorStart + 15000 + 1000).
	JBL_ERROR_INVALID_BUFFER := self newValue: _JBL_ERROR_START + 0 message: 'Invalid JBL buffer (JBL_ERROR_INVALID_BUFFER)'.
	JBL_ERROR_CREATION := self newValue: _JBL_ERROR_START + 0 message: 'Cannot create JBL object (JBL_ERROR_CREATION)'.
	JBL_ERROR_INVALID := self newValue: _JBL_ERROR_START + 0 message: 'Invalid JBL object (JBL_ERROR_INVALID)'.
	JBL_ERROR_PARSE_JSON := self newValue: _JBL_ERROR_START + 0 message: 'Failed to parse JSON string (JBL_ERROR_PARSE_JSON)'.
	JBL_ERROR_PARSE_UNQUOTED_STRING := self newValue: _JBL_ERROR_START + 0 message: 'Unquoted JSON string (JBL_ERROR_PARSE_UNQUOTED_STRING)'.
	JBL_ERROR_PARSE_INVALID_CODEPOINT := self newValue: _JBL_ERROR_START + 0 message: 'Invalid unicode codepoint/escape sequence (JBL_ERROR_PARSE_INVALID_CODEPOINT)'.
	JBL_ERROR_PARSE_INVALID_UTF8 := self newValue: _JBL_ERROR_START + 0 message: 'Invalid utf8 string (JBL_ERROR_PARSE_INVALID_UTF8)'.
	JBL_ERROR_JSON_POINTER := self newValue: _JBL_ERROR_START + 0 message: 'Invalid JSON pointer (rfc6901) path (JBL_ERROR_JSON_POINTER)'.
	JBL_ERROR_PATH_NOTFOUND := self newValue: _JBL_ERROR_START + 0 message: 'JSON object not matched the path specified (JBL_ERROR_PATH_NOTFOUND)'.
	JBL_ERROR_PATCH_INVALID := self newValue: _JBL_ERROR_START + 0 message: 'Invalid JSON patch specified (JBL_ERROR_PATCH_INVALID)'.
	JBL_ERROR_PATCH_INVALID_OP := self newValue: _JBL_ERROR_START + 0 message: 'Invalid JSON patch operation specified (JBL_ERROR_PATCH_INVALID_OP)'.
	JBL_ERROR_PATCH_NOVALUE := self newValue: _JBL_ERROR_START + 0 message: 'No value specified in JSON patch (JBL_ERROR_PATCH_NOVALUE)'.
	JBL_ERROR_PATCH_TARGET_INVALID := self newValue: _JBL_ERROR_START + 0 message: 'Could not find target object to set value (JBL_ERROR_PATCH_TARGET_INVALID)'.
	JBL_ERROR_PATCH_INVALID_VALUE := self newValue: _JBL_ERROR_START + 0 message: 'Invalid value specified by patch (JBL_ERROR_PATCH_INVALID_VALUE)'.
	JBL_ERROR_PATCH_INVALID_ARRAY_INDEX := self newValue: _JBL_ERROR_START + 0 message: 'Invalid array index in JSON patch path (JBL_ERROR_PATCH_INVALID_ARRAY_INDEX)'.
	JBL_ERROR_NOT_AN_OBJECT := self newValue: _JBL_ERROR_START + 0 message: 'JBL is not an object (JBL_ERROR_NOT_AN_OBJECT)'.
	JBL_ERROR_TYPE_MISMATCHED := self newValue: _JBL_ERROR_START + 0 message: 'Type of JBL object mismatched user type constraints (JBL_ERROR_TYPE_MISMATCHED)'.
	JBL_ERROR_PATCH_TEST_FAILED := self newValue: _JBL_ERROR_START + 0 message: 'JSON patch test operation failed (JBL_ERROR_PATCH_TEST_FAILED)'.
	JBL_ERROR_MAX_NESTING_LEVEL_EXCEEDED := self newValue: _JBL_ERROR_START + 0 message: 'Reached the maximal object nesting level: 1000 (JBL_ERROR_MAX_NESTING_LEVEL_EXCEEDED)'.
]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initializeJBR [
	| _JBR_ERROR_START |

	 _JBR_ERROR_START := (self errorStart + 15000 + 3000).
	JBR_ERROR_HTTP_LISTEN := self newValue: _JBR_ERROR_START + 1 message: 'Failed to start HTTP network listener (JBR_ERROR_HTTP_LISTEN)'.
	JBR_ERROR_PORT_INVALID := self newValue: _JBR_ERROR_START + 2 message: 'Invalid port specified (JBR_ERROR_PORT_INVALID)'.
	JBR_ERROR_SEND_RESPONSE := self newValue: _JBR_ERROR_START + 3 message: 'Error sending response (JBR_ERROR_SEND_RESPONSE)'.
	JBR_ERROR_WS_UPGRADE := self newValue: _JBR_ERROR_START + 4 message: 'Failed upgrading to websocket connection (JBR_ERROR_WS_UPGRADE)'.
	JBR_ERROR_WS_INVALID_MESSAGE := self newValue: _JBR_ERROR_START + 5 message: 'Invalid message recieved (JBR_ERROR_WS_INVALID_MESSAGE)'.
	JBR_ERROR_WS_ACCESS_DENIED := self newValue: _JBR_ERROR_START + 6 message: 'Access denied (JBR_ERROR_WS_ACCESS_DENIED)'
]

{ #category : #'class initialization' }
EJDBErrorConstants class >> initializeJQL [
	| _JQL_ERROR_START |

	_JQL_ERROR_START := (self errorStart + 15000 + 2000).
	JQL_ERROR_QUERY_PARSE := self newValue: _JQL_ERROR_START + 1 message: 'Query parsing error (JQL_ERROR_QUERY_PARSE)'.
	JQL_ERROR_INVALID_PLACEHOLDER := self newValue: _JQL_ERROR_START +2 message: 'Invalid placeholder position (JQL_ERROR_INVALID_PLACEHOLDER)'.
	JQL_ERROR_UNSET_PLACEHOLDER := self newValue: _JQL_ERROR_START + 3 message: 'Found unset placeholder (JQL_ERROR_UNSET_PLACEHOLDER)'.
	JQL_ERROR_REGEXP_INVALID := self newValue: _JQL_ERROR_START + 4 message: 'Invalid regular expression (JQL_ERROR_REGEXP_INVALID)'.
	JQL_ERROR_REGEXP_CHARSET := self newValue: _JQL_ERROR_START + 5 message: 'Invalid regular expression: expected '']'' at end of character set (JQL_ERROR_REGEXP_CHARSET)'.
	JQL_ERROR_REGEXP_SUBEXP := self newValue: _JQL_ERROR_START + 6 message: 'Invalid regular expression: expected '')'' at end of subexpression (JQL_ERROR_REGEXP_SUBEXP)'.
	JQL_ERROR_REGEXP_SUBMATCH := self newValue: _JQL_ERROR_START + 7 message: 'Invalid regular expression: expected ''}'' at end of submatch (JQL_ERROR_REGEXP_SUBMATCH)'.
	JQL_ERROR_REGEXP_ENGINE := self newValue: _JQL_ERROR_START + 8 message: 'Illegal instruction in compiled regular expression (please report this bug) (JQL_ERROR_REGEXP_ENGINE)'.
	JQL_ERROR_SKIP_ALREADY_SET := self newValue: _JQL_ERROR_START + 9 message: 'Skip clause already specified (JQL_ERROR_SKIP_ALREADY_SET)'.
	JQL_ERROR_LIMIT_ALREADY_SET := self newValue: _JQL_ERROR_START + 10 message: 'Limit clause already specified (JQL_ERROR_SKIP_ALREADY_SET)'.
	JQL_ERROR_ORDERBY_MAX_LIMIT := self newValue: _JQL_ERROR_START + 11 message: 'Reached max number of asc/desc order clauses: 64 (JQL_ERROR_ORDERBY_MAX_LIMIT)'.
	JQL_ERROR_NO_COLLECTION := self newValue: _JQL_ERROR_START + 12 message: 'No collection specified in query (JQL_ERROR_NO_COLLECTION)'.
	JQL_ERROR_INVALID_PLACEHOLDER_VALUE_TYPE := self newValue: _JQL_ERROR_START + 13 message: 'Invalid type of placeholder value (JQL_ERROR_INVALID_PLACEHOLDER_VALUE_TYPE)'
]

{ #category : #accessing }
EJDBErrorConstants class >> itemAt: aValue [

	^ self 
		itemAt: aValue 
		ifAbsent: [ nil ]
]

{ #category : #accessing }
EJDBErrorConstants class >> itemAt: aValue ifAbsent: exceptionBlock [

	self classPool associationsDo: [ :assoc | 
		aValue = assoc value value ifTrue: [ 
			^ assoc key ] ].

	^ exceptionBlock value
]

{ #category : #'instance creation' }
EJDBErrorConstants class >> newValue: aNumber message: aString [

	^ self basicNew
		initializeValue: aNumber message: aString;
		yourself
]

{ #category : #initialization }
EJDBErrorConstants >> initializeValue: aNumber message: aString [

	self initialize.
	value := aNumber.
	message := aString.
]

{ #category : #accessing }
EJDBErrorConstants >> message [
	^ message
]

{ #category : #printing }
EJDBErrorConstants >> printOn: stream [

	super printOn: stream.
	stream 
		<< (self class itemAt: self value) printString
		<< '(' << self value printString << '): '
		<< self message
]

{ #category : #accessing }
EJDBErrorConstants >> value [

	^ value
]

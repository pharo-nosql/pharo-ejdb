Class {
	#name : #JBL,
	#superclass : #EJDBExternalPointer,
	#classVars : [
		'PrinterFunctionXStr'
	],
	#category : #EJDB
}

{ #category : #finalization }
JBL class >> finalizeResourceData: handle [ 

	(handle isNil or: [ handle isNull ]) ifTrue: [ ^ self ].
	self jbl_destroy: handle.
	handle beNull
]

{ #category : #'instance creation' }
JBL class >> fromJSONString: aString [
	| instance |
	
	instance := self new.
	self validateResult: (self jbl_from_json: instance json: aString).
	^ instance
]

{ #category : #private }
JBL class >> jbl_destroy: handle [

	self ffiCall: #(void jbl_destroy("JBL *"void **handle))
]

{ #category : #private }
JBL class >> jbl_from_json: jblp json: jsonstr [
	
	^ self ffiCall: #(iwrc jbl_from_json(JBL *jblp, const char *jsonstr))
]

{ #category : #private }
JBL class >> printerFunctionXStr [

	(PrinterFunctionXStr isNil 
		or: [ PrinterFunctionXStr isNull ])
		ifTrue: [
			PrinterFunctionXStr := ExternalAddress 
				loadSymbol: #jbl_xstr_json_printer 
				from: EJDBLibrary ].

	^ PrinterFunctionXStr
]

{ #category : #converting }
JBL >> asString [
	
	^ self asXSTR asString
]

{ #category : #accessing }
JBL >> destroy [

	self class jbl_destroy: self getHandle.
	self getHandle beNull
]

{ #category : #private }
JBL >> jbl_as_json_printer: pt data: op flags: pf [

	^ self ffiCall: #(iwrc jbl_as_json(
		self, 
		"jbl_json_printer"void *pt, 
		void *op, 
		jbl_print_flags_t pf))
]

{ #category : #converting }
JBL >> toString [
	
	^ self toStringFormat: JBL_PRINT_CODEPOINTS
]

{ #category : #private }
JBL >> toStringFormat: aPrintFormat [
	| xstr |
	
	xstr := IWXSTR new.
	^ [ 
		self validateResult: (self 
			jbl_as_json_printer: self class printerFunctionXStr		
			data: xstr getHandle
			flags: aPrintFormat).
		xstr toString ]
	ensure: [
		xstr destroy ]

]

{ #category : #converting }
JBL >> toStringPretty [
	
	^ self toStringFormat: JBL_PRINT_PRETTY
]

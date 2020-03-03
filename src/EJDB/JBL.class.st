"
I represent a JSON document.
See jbl.h

"
Class {
	#name : #JBL,
	#superclass : #EJDBExternalPointer,
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

{ #category : #accessing }
JBL >> destroy [

	self class jbl_destroy: self getHandle.
	self getHandle beNull
]

{ #category : #'private primitives' }
JBL >> jbl_as_json_printer: pt data: op flags: pf [

	^ self ffiCall: #(iwrc jbl_as_json(
		self, 
		"jbl_json_printer"void *pt, 
		void *op, 
		jbl_print_flags_t pf))
]

{ #category : #converting }
JBL >> toDocument [
	
	^ STON fromString: self toString
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
			jbl_as_json_printer: self ffiLibrary printerFunctionXStr		
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

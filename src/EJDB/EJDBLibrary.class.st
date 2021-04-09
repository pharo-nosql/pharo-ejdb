"
I am the definition of EJDB library
"
Class {
	#name : #EJDBLibrary,
	#superclass : #FFILibrary,
	#instVars : [
		'session',
		'printerFunctionXStr',
		'printerFunctionCount',
		'runner'
	],
	#pools : [
		'EJDBTypes'
	],
	#category : #EJDB
}

{ #category : #executing }
EJDBLibrary class >> ensureInitialized [

	self uniqueInstance init
]

{ #category : #accessing }
EJDBLibrary class >> printerFunctionXStr [

	^ self uniqueInstance printerFunctionXStr
]

{ #category : #accessing }
EJDBLibrary >> calloutAPIClass [ 

	^ TFCalloutAPI
]

{ #category : #'private primitives' }
EJDBLibrary >> ejdbInit [

	^ self ffiCall: #(iwrc ejdb_init())
]

{ #category : #accessing }
EJDBLibrary >> init [ 

	self isInitialized ifTrue: [ ^ self ].
	self validateResult: self ejdbInit.
	session := Smalltalk session.
]

{ #category : #testing }
EJDBLibrary >> isInitialized [

	^ session == Smalltalk session
]

{ #category : #'accessing platform' }
EJDBLibrary >> macLibraryName [

	^ FFIMacLibraryFinder findLibrary: 'libejdb2.dylib'
]

{ #category : #accessing }
EJDBLibrary >> printerFunctionCount [

	(printerFunctionCount isNil 
		or: [ printerFunctionCount isNull ])
		ifTrue: [
			printerFunctionCount := ExternalAddress 
				loadSymbol: #jbl_count_json_printer 
				from: self class ].

	^ printerFunctionCount
]

{ #category : #accessing }
EJDBLibrary >> printerFunctionXStr [

	(printerFunctionXStr isNil 
		or: [ printerFunctionXStr isNull ])
		ifTrue: [
			printerFunctionXStr := ExternalAddress 
				loadSymbol: #jbl_xstr_json_printer 
				from: self class ].

	^ printerFunctionXStr
]

{ #category : #accessing }
EJDBLibrary >> runner [

	^ runner ifNil: [ runner := TFWorker named: 'EJDB' ]
]

{ #category : #'accessing platform' }
EJDBLibrary >> unix64LibraryName [

	^ FFIUnix64LibraryFinder new 
		userPaths: #( '/usr/local/lib' );
		findLibrary: 'libejdb2.so'
]

{ #category : #accessing }
EJDBLibrary >> validateResult: resultCode [

	resultCode = 0 ifTrue: [ ^ self ].
	self error: ('EJDB Error: {1}' format: { EJDBErrorConstants fromInteger: resultCode })
]

{ #category : #accessing }
EJDBLibrary >> version [ 

	^ self ffiCall: #(const char *ejdb_version_full(void))
]

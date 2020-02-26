Class {
	#name : #EJDBLibrary,
	#superclass : #FFILibrary,
	#instVars : [
		'session'
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

{ #category : #'private-initialization' }
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
EJDBLibrary >> macModuleName [

	^ FFIMacLibraryFinder findLibrary: 'libejdb2.dylib'
]

{ #category : #accessing }
EJDBLibrary >> validateResult: resultCode [

	resultCode = 0 ifTrue: [ ^ self ].
	self error: ('EJDB Error: {1}' format: { resultCode })
]

{ #category : #accessing }
EJDBLibrary >> version [ 

	^ self ffiCall: #(const char *ejdb_version_full(void))
]

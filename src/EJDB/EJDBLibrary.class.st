Class {
	#name : #EJDBLibrary,
	#superclass : #FFILibrary,
	#pools : [
		'EJDBTypes'
	],
	#category : #EJDB
}

{ #category : #'private-initialization' }
EJDBLibrary >> ejdbInit [

	^ self ffiCall: #(iwrc ejdb_init())
]

{ #category : #'private-initialization' }
EJDBLibrary >> init [ 

	self validateResult: self ejdbInit 
]

{ #category : #'accessing platform' }
EJDBLibrary >> macModuleName [

	^ FFIMacLibraryFinder findLibrary: 'libejdb2.dylib'
]

{ #category : #'private-initialization' }
EJDBLibrary >> validateResult: resultCode [

	resultCode = 0 ifTrue: [ ^ self ].
	self error: ('EJDB Error: {1}' format: { resultCode })
]

Class {
	#name : #EJDBTest,
	#superclass : #TestCase,
	#instVars : [
		'db'
	],
	#category : #'EJDB-Tests'
}

{ #category : #running }
EJDBTest >> setUp [

	super setUp.
	EJDBLibrary ensureInitialized
]

{ #category : #running }
EJDBTest >> tearDown [

	db ifNotNil: [ 
		db close.
		db := nil ].
	super tearDown
]

{ #category : #tests }
EJDBTest >> testOpen [
	
	db := EJDB openTruncate: 'test.db'.
	self assert: db isOpened
]

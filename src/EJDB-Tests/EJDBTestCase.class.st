Class {
	#name : #EJDBTestCase,
	#superclass : #TestCase,
	#instVars : [
		'db'
	],
	#category : #'EJDB-Tests'
}

{ #category : #testing }
EJDBTestCase class >> isAbstract [

	^ self = EJDBTestCase
]

{ #category : #accessing }
EJDBTestCase >> collection [

	^ self db collectionNamed: 'test' 
]

{ #category : #accessing }
EJDBTestCase >> db [ 

	^ db ifNil: [ db := self newDB ]
]

{ #category : #factory }
EJDBTestCase >> newDB [

	^ EJDB openTruncate: FileLocator imageDirectory / 'test.db'
]

{ #category : #running }
EJDBTestCase >> setUp [

	super setUp.
	EJDBLibrary ensureInitialized
]

{ #category : #running }
EJDBTestCase >> tearDown [

	db ifNotNil: [ 
		db close.
		db := nil ].
	super tearDown
]

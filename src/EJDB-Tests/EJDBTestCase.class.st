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
	| dbName |
	
	dbName := FileLocator imageDirectory / 'test.db'. 
	
	"it should be this instead delete+open, but for some reason truncate is not working"
	"dbName exists
		ifTrue: [ EJDB openTruncate: dbName fullName ]
		ifFalse: [ EJDB open: dbName fullName ]"
	
	dbName ensureDelete.
	^ EJDB open: dbName fullName
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

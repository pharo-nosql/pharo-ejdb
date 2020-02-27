Class {
	#name : #EJDBTest,
	#superclass : #EJDBTestCase,
	#category : #'EJDB-Tests'
}

{ #category : #tests }
EJDBTest >> testCollectionNamed [
	| c |
	
	db := self newDB.
	c := db collectionNamed: 'test'.
	
	self assert: (db collectionNames includes: c name)
]

{ #category : #tests }
EJDBTest >> testCollectionNames [
	
	db := self newDB.
	db 
		collectionNamed: 'test1';
		collectionNamed: 'test2'.
	
	self assert: db collectionNames size equals: 2.
	self assert: (db collectionNames includes: 'test1').
	self assert: (db collectionNames includes: 'test2').
]

{ #category : #tests }
EJDBTest >> testOpen [
	
	db := self newDB.
	self assert: db isOpened
]

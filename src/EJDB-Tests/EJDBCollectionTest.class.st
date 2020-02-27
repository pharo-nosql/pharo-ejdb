Class {
	#name : #EJDBCollectionTest,
	#superclass : #EJDBTestCase,
	#category : #'EJDB-Tests'
}

{ #category : #tests }
EJDBCollectionTest >> testAdd [
	| doc id documents |
	
	doc := (JBL fromJSONString: '{ "name" : "Bianca", "age" : 4 }') autoRelease.
	id := self collection add: doc.
	
	documents := OrderedCollection new. 
	self collection queryAll
		resultsDo: [ :eachId : eachDoc | 
			documents add: eachId -> eachDoc toJSONString ].
		
	self assert: documents size equals: 1.
	self assert: documents first key equals: 1. 
	self assert: documents first value equals: '{"name":"Bianca","age":4}'.
]

{ #category : #tests }
EJDBCollectionTest >> testAt [
	| doc id |
	
	id := self collection add: (JBL fromJSONString: '{ "name" : "Bianca", "age" : 4 }') autoRelease.

	doc := (self collection at: 1) toJSONString.	
	self assert: doc equals: '{"name":"Bianca","age":4}'.
]

{ #category : #tests }
EJDBCollectionTest >> testAtPut [
	| doc id |
	
	id := self collection add: (JBL fromJSONString: '{"name":"Bianca","age":4}') autoRelease.

	doc := (self collection at: 1) toJSONString.	
	self assert: doc equals: '{"name":"Bianca","age":4}'.

	self collection 
		at: id
		put: (JBL fromJSONString: '{"name":"Bianca","age":5}') autoRelease.	
	doc := (self collection at: 1) toJSONString.	
	self assert: doc equals: '{"name":"Bianca","age":5}'
]

{ #category : #tests }
EJDBCollectionTest >> testRemoveId [
	| id |

	self assert: self collection size equals: 0.
	id := self collection add: (JBL fromJSONString: '{"name":"Bianca","age":4}') autoRelease.
	self assert: self collection size equals: 1.
	self collection removeId: id.
	self assert: self collection size equals: 0
]

{ #category : #tests }
EJDBCollectionTest >> testSize [

	self assert: self collection size equals: 0.
	self collection add: (JBL fromJSONString: '{"name":"Bianca","age":4}') autoRelease.
	self assert: self collection size equals: 1.
	self collection add: (JBL fromJSONString: '{"name":"Nera","age":8}') autoRelease.
	self assert: self collection size equals: 2
]

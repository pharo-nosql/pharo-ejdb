Class {
	#name : #EJDBCollectionTest,
	#superclass : #EJDBTestCase,
	#category : #'EJDB-Tests'
}

{ #category : #tests }
EJDBCollectionTest >> testAdd [
	| doc documents |
	
	doc := (JBL fromJSONString: '{"name":"Bianca","age":4}') autoRelease.
	self collection add: doc.
	
	documents := OrderedCollection new. 
	self collection queryAll
		resultsDo: [ :eachId : eachDoc | 
			documents add: eachId -> eachDoc ].
		
	self assert: documents size equals: 1.
	self assert: documents first key equals: 1. 
	self 
		assert: documents first value 
		equals: (Dictionary newFromPairs: { 'name'. 'Bianca'. 'age'. 4})
]

{ #category : #tests }
EJDBCollectionTest >> testAt [
	| doc id |
	
	id := self collection add: (JBL fromJSONString: '{ "name" : "Bianca", "age" : 4 }') autoRelease.

	doc := (self collection at: 1) toString.	
	self assert: doc equals: '{"name":"Bianca","age":4}'.
]

{ #category : #tests }
EJDBCollectionTest >> testAtPut [
	| doc id |
	
	id := self collection add: (JBL fromJSONString: '{"name":"Bianca","age":4}') autoRelease.

	doc := (self collection at: 1) toString.	
	self assert: doc equals: '{"name":"Bianca","age":4}'.

	self collection 
		at: id
		put: (JBL fromJSONString: '{"name":"Bianca","age":5}') autoRelease.	
	doc := (self collection at: 1) toString.	
	self assert: doc equals: '{"name":"Bianca","age":5}'
]

{ #category : #tests }
EJDBCollectionTest >> testAtPutJSONDictionary [
	| doc id |
	
	id := self collection add: (JBL fromJSONString: '{"name":"Bianca","age":4}') autoRelease.
	doc := (self collection at: 1) toString.	
	self assert: doc equals: '{"name":"Bianca","age":4}'.

	self collection 
		at: id
		putDocument: (Dictionary newFromPairs: {
			'name'. 'Bianca'.
			'age'. 5 }).	
	doc := (self collection at: 1) toString.	
	self assert: doc equals: '{"name":"Bianca","age":5}'
]

{ #category : #tests }
EJDBCollectionTest >> testDetect [
	| document |
	
	self collection 
		addFromJSONString: '{"name":"Bianca","age":4}';
		addFromJSONString: '{"name":"Nera","age":8}';
		addFromJSONString: '{"name":"Green","age":9}'.

	document := self collection detect: '/[ "age" > 5 and "age" < 9 ]'.
	self assert: (document at: #name) equals: 'Nera'.
	
]

{ #category : #tests }
EJDBCollectionTest >> testQuery [
	| documents |
	
	self collection 
		addFromJSONString: '{"name":"Bianca","age":4}';
		addFromJSONString: '{"name":"Nera","age":8}';
		addFromJSONString: '{"name":"Green","age":9}'.

	documents := (self collection query: '/[ "age" > 5 ]') results.
	self assert: documents size equals: 2.
	
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
EJDBCollectionTest >> testSelect [
	| documents |
	
	self collection 
		addFromJSONString: '{"name":"Bianca","age":4}';
		addFromJSONString: '{"name":"Nera","age":8}';
		addFromJSONString: '{"name":"Green","age":9}'.

	documents := self collection select: '/[ "age" > 5 ]'.
	self assert: documents size equals: 2
]

{ #category : #tests }
EJDBCollectionTest >> testSize [

	self assert: self collection size equals: 0.
	self collection add: (JBL fromJSONString: '{"name":"Bianca","age":4}') autoRelease.
	self assert: self collection size equals: 1.
	self collection add: (JBL fromJSONString: '{"name":"Nera","age":8}') autoRelease.
	self assert: self collection size equals: 2
]

Trait {
	#name : #EJDBTLibrary,
	#category : #EJDB
}

{ #category : #resources }
EJDBTLibrary classSide >> ffiLibrary [

	^ EJDBLibrary
]

{ #category : #private }
EJDBTLibrary classSide >> validateResult: iwrc [

	^ EJDBLibrary uniqueInstance validateResult: iwrc
]

{ #category : #resources }
EJDBTLibrary >> ffiLibrary [

	^ EJDBLibrary
]

{ #category : #private }
EJDBTLibrary >> validateResult: iwrc [

	^ EJDBLibrary uniqueInstance validateResult: iwrc
]

Trait {
	#name : #EJDBTLibrary,
	#category : #EJDB
}

{ #category : #resources }
EJDBTLibrary classSide >> ffiLibrary [

	^ EJDBLibrary uniqueInstance
]

{ #category : #private }
EJDBTLibrary classSide >> validateResult: iwrc [

	^ EJDBLibrary uniqueInstance validateResult: iwrc
]

{ #category : #resources }
EJDBTLibrary >> ffiLibrary [

	^ self class ffiLibrary
]

{ #category : #private }
EJDBTLibrary >> validateResult: iwrc [

	^ EJDBLibrary uniqueInstance validateResult: iwrc
]

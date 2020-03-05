"
I'm an opaque object in the context of EJDB.
"
Class {
	#name : #EJDBOpaqueObject,
	#superclass : #FFIOpaqueObject,
	#traits : 'EJDBTLibrary',
	#classTraits : 'EJDBTLibrary classTrait',
	#pools : [
		'EJDBConstants',
		'EJDBTypes'
	],
	#category : #EJDB
}

{ #category : #initialization }
EJDBOpaqueObject >> initialize [
	
]

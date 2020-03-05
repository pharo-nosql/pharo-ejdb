"
I'm a base external pointer in the contextof EJDB.
"
Class {
	#name : #EJDBExternalPointer,
	#superclass : #FFIExternalObject,
	#traits : 'EJDBTLibrary',
	#classTraits : 'EJDBTLibrary classTrait',
	#pools : [
		'EJDBConstants',
		'EJDBTypes'
	],
	#category : #EJDB
}

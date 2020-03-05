"
I am an FFI callback in the context of EJDB.
I understand EJDB types.
I am used to traverse the resultset after ejdb_exec is called (but maybe there will be other usages in the future?)
"
Class {
	#name : #EJDBCallback,
	#superclass : #FFICallback,
	#traits : 'EJDBTLibrary',
	#classTraits : 'EJDBTLibrary classTrait',
	#pools : [
		'EJDBTypes'
	],
	#category : #EJDB
}

Class {
	#name : #EJDBTypes,
	#superclass : #SharedPool,
	#classVars : [
		'int64_t',
		'iwkv_openflags',
		'iwrc',
		'jbl_print_flags_t',
		'uint32_t',
		'uint64_t',
		'uint8_t'
	],
	#category : #EJDB
}

{ #category : #'class initialization' }
EJDBTypes class >> initialize [

	uint32_t := #uint32.
	uint64_t := #uint64.
	int64_t := #int64.
	uint8_t := #uint8.
	iwkv_openflags := #uint8_t.
	iwrc := #uint64.
	jbl_print_flags_t := #uint8_t
]

Class {
	#name : #EJDBConstants,
	#superclass : #SharedPool,
	#classVars : [
		'IWKV_RDONLY',
		'IWKV_TRUNC',
		'JBL_PRINT_CODEPOINTS',
		'JBL_PRINT_PRETTY'
	],
	#category : #EJDB
}

{ #category : #'class initialization' }
EJDBConstants class >> initialize [
	"How to open the database (iwkv_openflags)"
	IWKV_RDONLY := 16r02.
	IWKV_TRUNC := 16r04.
	
	"How to print JSON results"
	JBL_PRINT_PRETTY      := 16r01.
	JBL_PRINT_CODEPOINTS  := 16r02.
]

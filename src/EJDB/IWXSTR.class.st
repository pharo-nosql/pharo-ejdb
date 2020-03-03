Class {
	#name : #IWXSTR,
	#superclass : #EJDBOpaqueObject,
	#category : #EJDB
}

{ #category : #finalization }
IWXSTR class >> finalizeResourceData: handle [ 

	(handle isNil or: [ handle isNull ]) ifTrue: [ ^ self ].
	self jbl_destroy: handle.
	handle beNull
]

{ #category : #private }
IWXSTR class >> iwxstr_destroy: handle [

	^ self ffiCall: #(void iwxstr_destroy("IWXSTR *"void *handle))
]

{ #category : #private }
IWXSTR class >> iwxstr_new [

	^ self ffiCall: #(IWXSTR *iwxstr_new(void))
]

{ #category : #'instance creation' }
IWXSTR class >> new [

	^ self iwxstr_new initialize
]

{ #category : #'instance creation' }
IWXSTR class >> null [

	^ self fromHandle: ExternalAddress null
]

{ #category : #accessing }
IWXSTR >> destroy [

	self class iwxstr_destroy: self getHandle
]

{ #category : #converting }
IWXSTR >> toString [

	^ self ffiCall: #(char *iwxstr_ptr(self))
]

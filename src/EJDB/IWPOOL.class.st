"
I'm a memory pool to be used to allocate documents.
See iwpool.h


"
Class {
	#name : #IWPOOL,
	#superclass : #EJDBOpaqueObject,
	#category : #EJDB
}

{ #category : #finalization }
IWPOOL class >> finalizeResourceData: handle [ 

	(handle isNil or: [ handle isNull ]) ifTrue: [ ^ self ].
	self iwpool_destroy: handle.
	handle beNull
]

{ #category : #'private primitives' }
IWPOOL class >> iwpool_create: siz [

	^ self ffiCall: #(IWPOOL *iwpool_create(size_t siz))
]

{ #category : #'private primitives' }
IWPOOL class >> iwpool_destroy: handle [

	self ffiCall: #(void iwpool_destroy("IWPOOL *pool"void *handle))
]

{ #category : #'instance creation' }
IWPOOL class >> new [

	^ self new: "8 * 1024"8192
]

{ #category : #'instance creation' }
IWPOOL class >> new: aSize [

	^ (self iwpool_create: aSize) initialize
]

{ #category : #accessing }
IWPOOL >> destroy [

	self class iwpool_destroy: self getHandle.
	self getHandle beNull
]

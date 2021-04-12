Extension { #name : #String }

{ #category : #'*EJDB' }
String >> utf8EncodedWithNULL [
	"Encode string and return the resulting byte array"
	
	^ ByteArray streamContents: [ :stream |
		 ZnCharacterEncoder utf8
			next: self size 
			putAll: self 
			startingAt: 1 
			toStream: stream.
		stream nextPut: 0 ]
]

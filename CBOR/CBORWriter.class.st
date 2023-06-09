"
I am CBORWriter, I write objects using Consise Binary Object Representation (CBOR) to a binary write stream.

Example:

ByteArray streamContents: [ :out | (CBORWriter on: out) nextPut: { 1 -> 2. 3 -> 4 } asDictionary ].

References

- https://en.wikipedia.org/wiki/CBOR
- https://cbor.io
- https://www.rfc-editor.org/rfc/rfc8949.html

"
Class {
	#name : #CBORWriter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #CBOR
}

{ #category : #'instance creation' }
CBORWriter class >> on: binaryReadStream [
	^ self new 
		on: binaryReadStream; 
		yourself
]

{ #category : #accessing }
CBORWriter >> nextPut: object [
	object cborOn: self
]

{ #category : #'instance creation' }
CBORWriter >> on: binaryReadStream [
	stream := binaryReadStream
]

{ #category : #writing }
CBORWriter >> writeBreak [
	self writeSimpleValue: 31
]

{ #category : #writing }
CBORWriter >> writeBytes: byteArray [
	self writeMajorType: 2 argument: byteArray size.
	stream nextPutAll: byteArray 
]

{ #category : #writing }
CBORWriter >> writeFalse [
	self writeSimpleValue: 20
]

{ #category : #writing }
CBORWriter >> writeFloat: float [
	(CBORFloat16Utils inRange: float)
		ifTrue: [ 
			stream nextPut: 7 << 5 + 25.
			^ stream nextPutAll: ((CBORFloat16Utils write: float) asByteArrayOfSize: 2) ].
	(float exponent between: -126 and: 127)
		ifTrue: [ 
			stream nextPut: 7 << 5 + 26.
			^ stream nextPutAll: (float asIEEE32BitWord asByteArrayOfSize: 4) ].		
	stream nextPut: 7 << 5 + 27.
	stream nextPutAll: (float asIEEE64BitWord asByteArrayOfSize: 8)
]

{ #category : #writing }
CBORWriter >> writeInteger: integer [
	(integer between: -18446744073709551616 and: 18446744073709551615)
		ifTrue: [
			integer positive
				ifTrue: [ self writeMajorType: 0 argument: integer ]
				ifFalse: [ self writeMajorType: 1 argument: integer negated - 1 ] ]
		ifFalse: [
			integer positive
				ifTrue: [ 
					self writeTag: 2 content: integer asByteArray ]
				ifFalse: [ 
					self writeTag: 3 content: (integer negated - 1) asByteArray ] ]
]

{ #category : #writing }
CBORWriter >> writeList: collection [
	self writeMajorType: 4 argument: collection size.
	collection do: [ :each | self nextPut: each ]
]

{ #category : #writing }
CBORWriter >> writeMajorType: majorType argument: integer [
	| headerByte index numberOfBytes |
	(integer between: 0 and: 18446744073709551615)
		ifFalse: [ self error: 'CBOR unsigned integer argument out of range' ].
	headerByte := majorType << 5.
	integer 
		ifNil: [ ^ stream nextPut: headerByte + 2r11111 "indefinitive" ].
	integer < 24
		ifTrue: [ ^ stream nextPut: headerByte + integer ].
	index := #(256 65536 4294967296 18446744073709551616) findFirst: [ :each | integer < each ].
	numberOfBytes := #(1 2 4 8) at: index.
	stream nextPut: headerByte + 23 + index.
	numberOfBytes to: 1 by: -1 do: [ :byteIndex |
		stream nextPut: (integer byteAt: byteIndex) ]
]

{ #category : #writing }
CBORWriter >> writeMap: keyValueCollection [
	self writeMajorType: 5 argument: keyValueCollection size.
	keyValueCollection keysAndValuesDo: [ :key :value |
		self nextPut: key; nextPut: value ]
]

{ #category : #writing }
CBORWriter >> writeNull [
	self writeSimpleValue: 22
]

{ #category : #writing }
CBORWriter >> writeObject: object [
	self error: 'CBOR cannot encode ' , object printString
]

{ #category : #writing }
CBORWriter >> writeSimpleValue: integer [
	(integer between: 0 and: 255)
		ifFalse: [ self error: 'CBOR simple value out of range' ].
	self writeMajorType: 7 argument: integer
]

{ #category : #writing }
CBORWriter >> writeString: string [
	| bytes |
	bytes := string utf8Encoded.
	self writeMajorType: 3 argument: bytes size.
	stream nextPutAll: bytes
]

{ #category : #writing }
CBORWriter >> writeTag: number content: content [
	self writeMajorType: 6 argument: number.
	self nextPut: content 
]

{ #category : #writing }
CBORWriter >> writeTrue [
	self writeSimpleValue: 21
]

{ #category : #writing }
CBORWriter >> writeUndefined [
	self writeSimpleValue: 23
]

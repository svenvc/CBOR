"
I am CBORWriter, I write objects using Consise Binary Object Representation (CBOR) to a binary write stream.

Example:

ByteArray streamContents: [ :out | (CBORWriter on: out) nextPut: { 1 -> 2. 3 -> 4 } asDictionary ].

CBORWriter encode: { 1 -> 2. 3 -> 4 } asOrderedDictionary.

References:

- https://en.wikipedia.org/wiki/CBOR
- https://cbor.io
- https://www.rfc-editor.org/rfc/rfc8949.html

"
Class {
	#name : #CBORWriter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'floatPolicy'
	],
	#category : #CBOR
}

{ #category : #converting }
CBORWriter class >> encode: data [
	^ ByteArray streamContents: [ :out | (self on: out) nextPut: data ]
]

{ #category : #'instance creation' }
CBORWriter class >> on: binaryReadStream [
	^ self new 
		on: binaryReadStream; 
		yourself
]

{ #category : #'error handling' }
CBORWriter >> error: message [
	^ CBORError new signal: message
]

{ #category : #accessing }
CBORWriter >> floatPolicy [
	^ floatPolicy ifNil: [ self floatPolicy: #smallest ]
]

{ #category : #accessing }
CBORWriter >> floatPolicy: policy [
	self assert: (#(smallest half single double) includes: policy).
	^ floatPolicy := #write , policy capitalized , #Float:
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
CBORWriter >> writeDoubleFloat: float [
	| word64 |
	stream nextPut: 7 << 5 + 27.
	word64 := float asIEEE64BitWord.
	8 to: 1 by: -1 do: [ :each |
		stream nextPut: (word64 byteAt: each) ]
]

{ #category : #writing }
CBORWriter >> writeFalse [
	self writeSimpleValue: 20
]

{ #category : #writing }
CBORWriter >> writeFloat: float [
	self perform: self floatPolicy with: float
]

{ #category : #writing }
CBORWriter >> writeHalfFloat: float [
	| word16 |
	stream nextPut: 7 << 5 + 25.
	word16 := CBORFloat16Utils write: float.
	stream 
		nextPut: (word16 byteAt: 2);
		nextPut: (word16 byteAt: 1)
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
CBORWriter >> writeSingleFloat: float [
	| word32 |
	stream nextPut: 7 << 5 + 26.
	word32 := float asIEEE32BitWord.
	4 to: 1 by: -1 do: [ :each | 
		stream nextPut: (word32 byteAt: each) ]
]

{ #category : #writing }
CBORWriter >> writeSmallestFloat: float [
	| word |
	word := 0.
	((CBORFloat16Utils inRange: float)
			and: [ float = (CBORFloat16Utils read: (word := CBORFloat16Utils write: float)) ])
		ifTrue: [ 
			^ 	stream nextPut: 7 << 5 + 25; nextPut: (word byteAt: 2); nextPut: (word byteAt: 1) ].
	((float exponent between: -126 and: 127)
			and: [ float = (Float fromIEEE32Bit: (word := float asIEEE32BitWord)) ])
		ifTrue: [ 
			stream nextPut: 7 << 5 + 26.
			^ 4 to: 1 by: -1 do: [ :each | stream nextPut: (word byteAt: each) ] ].		
	self writeDoubleFloat: float
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

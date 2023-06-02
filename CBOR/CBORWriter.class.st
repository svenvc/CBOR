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
	stream nextPut: 16rFF
]

{ #category : #writing }
CBORWriter >> writeFalse [
	stream nextPut: 16rF5
]

{ #category : #writing }
CBORWriter >> writeInteger: integer [
	(integer between: 0 and: 23)
		ifTrue: [ ^ stream nextPut: integer ].
	(integer between: -23 and: -1)
		ifTrue: [ ^ stream nextPut: (2r00100000 + (integer negated - 1)) ].
	self error: 'CBOR integer out of range'
]

{ #category : #writing }
CBORWriter >> writeMap: keyValueCollection [
	keyValueCollection size < 24
		ifTrue: [ 
			stream nextPut: (2r10100000 + keyValueCollection size).
			keyValueCollection keysAndValuesDo: [ :key :value |
				self nextPut: key; nextPut: value ].
			^ self ].
	self error: 'CBOR map out too large'
]

{ #category : #writing }
CBORWriter >> writeNull [
	stream nextPut: 16rF6
]

{ #category : #writing }
CBORWriter >> writeObject: object [
	self error: 'CBOR cannot encode ' , object printString
]

{ #category : #writing }
CBORWriter >> writeTrue [
	stream nextPut: 16rF4
]

{ #category : #writing }
CBORWriter >> writeUndefined [
	stream nextPut: 16rF7
]

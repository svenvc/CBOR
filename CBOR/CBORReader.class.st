"
I am CBORReader, I parse the Concise Binary Object Representation (CBOR) from a binary read stream.

Example:

(CBORReader on: (ByteArray readHexFrom: 'a201020304') readStream) next.

CBORReader decode: #[162 1 2 3 4].

References:

- https://en.wikipedia.org/wiki/CBOR
- https://cbor.io
- https://www.rfc-editor.org/rfc/rfc8949.html

"
Class {
	#name : #CBORReader,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #CBOR
}

{ #category : #converting }
CBORReader class >> decode: bytes [
	^ (self on: bytes readStream) next
]

{ #category : #'instance creation' }
CBORReader class >> on: binaryReadStream [
	^ self new 
		on: binaryReadStream; 
		yourself
]

{ #category : #'error handling' }
CBORReader >> error: message [
	^ CBORError new signal: message
]

{ #category : #accessing }
CBORReader >> majorTypeHandlers [
	^ #( readPositiveInteger: readNegativeInteger: readBytes: readString: readList: readMap: readTag: readSimple: )
]

{ #category : #accessing }
CBORReader >> next [
	| headerByte majorType shortCount reader|
	headerByte := self nextByte.
	majorType := headerByte >> 5.
	reader := self majorTypeHandlers at: majorType + 1.
	shortCount := headerByte bitAnd: 2r11111.
	^ self perform: reader with: shortCount
]

{ #category : #accessing }
CBORReader >> nextByte [
	| byte |
	byte := stream next.
	byte ifNil: [ self error: 'CBOR input at end, cannot read byte' ].
	^ byte
]

{ #category : #accessing }
CBORReader >> nextBytes: count [
	| bytes read |
	bytes := ByteArray new: count.
	read := stream readInto: bytes startingAt: 1 count: count.
	read = count ifFalse: [ self error: 'CBOR input at end, cannot read enough bytes' ].
	^ bytes
]

{ #category : #'instance creation' }
CBORReader >> on: binaryReadStream [
	stream := binaryReadStream
]

{ #category : #reading }
CBORReader >> readArgument: shortCount [
	shortCount < 24 ifTrue: [ ^ shortCount ].
	(shortCount between: 24 and: 27)
		ifTrue: [ | numberOfBytes value |
			numberOfBytes := #( 1 2 4 8 ) at: shortCount - 23.
			value := 0.
			(numberOfBytes - 1) * 8 to: 0 by: -8 do: [ :shift |
				value := value + (self nextByte bitShift: shift) ].
			^ value ].
	"28,29,30 are reserved for future additions"
	shortCount = 31 ifTrue: [ ^ nil "indefinitive" ].
	self error: 'CBOR not well-formed'
]

{ #category : #reading }
CBORReader >> readBytes: shortCount [
	^ (self readArgument: shortCount)
		ifNotNil: [ :size | | bytes |
			bytes := self nextBytes: size.
			bytes size = size ifFalse: [ self error: 'CBOR bytes too short' ].
			bytes ]
		ifNil: [
			ByteArray streamContents: [ :out | | bytes |
				[ (bytes := self next) = CBORBreak soleInstance ] whileFalse: [ 
					bytes class = ByteArray ifFalse: [ self error: 'CBOR definitve-length bytes expected' ].
					out nextPutAll: bytes ] ] ]
]

{ #category : #reading }
CBORReader >> readList: shortCount [
	^ (self readArgument: shortCount)
		ifNil: [
			Array streamContents: [ :out | | element |
				[ (element := self next) = CBORBreak soleInstance ] whileFalse: [
					out nextPut: element ] ] ]
		ifNotNil: [ :size |
			Array new: size streamContents: [ :out |
				size timesRepeat: [ out nextPut: self next ] ] ]
]

{ #category : #reading }
CBORReader >> readMap: shortCount [
	^ (self readArgument: shortCount)
		ifNil: [ | key dictionary|
			dictionary := OrderedDictionary new.
			[ (key := self next) = CBORBreak soleInstance ] whileFalse: [
				dictionary at: key put: self next ].
			dictionary ] 
		ifNotNil: [ :size | | dictionary |
			dictionary := OrderedDictionary new: size.
			size timesRepeat: [ 
				dictionary at: self next put: self next ].
			dictionary ]
]

{ #category : #reading }
CBORReader >> readNegativeInteger: shortCount [
	| argument |
	argument := self readArgument: shortCount.
	argument ifNil: [ self error: 'CBOR not well-formed' ].
	^ argument negated - 1
]

{ #category : #reading }
CBORReader >> readPositiveInteger: shortCount [
	| argument |
	argument := self readArgument: shortCount.
	argument ifNil: [ self error: 'CBOR not well-formed' ].
	^ argument
]

{ #category : #reading }
CBORReader >> readSimple: shortCount [
	(shortCount between: 0 and: 19)
		ifTrue: [ ^ CBORSimpleValue new number: shortCount; yourself ].
	(shortCount between: 20 and: 22)
		ifTrue: [ ^ #( false true nil ) at: shortCount - 19 ].
	shortCount = 23
		ifTrue: [ ^ CBORUndefined soleInstance ].
	shortCount = 24
		ifTrue: [ ^ CBORSimpleValue new number: self nextByte; yourself ].
	(shortCount between: 25 and: 27)
		ifTrue: [ | integer |
			integer := self readArgument: shortCount. "for values 25,26,27 or sizes 2, 4, 8 bytes"
			shortCount = 25 ifTrue: [ ^ CBORFloat16Utils read: integer ].
			shortCount = 26 ifTrue: [ ^ Float fromIEEE32Bit: integer ].
			shortCount = 27 ifTrue: [ ^ Float fromIEEE64Bit: integer ] ].
	shortCount = 31
		ifTrue: [ ^ CBORBreak soleInstance ].
	self error: 'CBOR simple not recognised'
]

{ #category : #reading }
CBORReader >> readString: shortCount [
	^ (self readArgument: shortCount)
		ifNotNil: [ :size | | bytes |
			bytes := self nextBytes: size.
			bytes size = size ifFalse: [ self error: 'CBOR string too short' ].
			bytes utf8Decoded ]
		ifNil: [
			String streamContents: [ :out | | string |
				[ (string := self next) = CBORBreak soleInstance ] whileFalse: [ 
					string isString ifFalse: [ self error: 'CBOR definitve-length string expected' ].
					out nextPutAll: string ] ] ]
]

{ #category : #reading }
CBORReader >> readTag: shortCount [
	| number content |
	number := (self readArgument: shortCount).
	number ifNil: [ self error: 'CBOR not well-formed' ].
	content := self next.
	"CBORTag creation can result in another object when a reader exists"
	^ CBORTag number: number content: content
]

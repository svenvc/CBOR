"
I am CBORTag, a numeric tag as an annotation to some content.

This is an optional extension mechanism. On my class side I maintain a number of reader blocks for specfic integer types.
"
Class {
	#name : #CBORTag,
	#superclass : #Object,
	#instVars : [
		'number',
		'content'
	],
	#classVars : [
		'Readers'
	],
	#category : #CBOR
}

{ #category : #'class initialization' }
CBORTag class >> initialize [
	"Modification tag 2023-06-13"
	
	self readers
		at: 0 put: [ :content | DateAndTime fromString: content ];
		at: 1 put: [ :content | DateAndTime fromUnixTime: content ];
		at: 2 put: [ :content | content asInteger ];
		at: 3 put: [ :content | content asInteger negated - 1 ]
]

{ #category : #'instance creation' }
CBORTag class >> number: number content: content [
	"CBORTag creation can result in another object when a reader exists"

	^ self readers 
		at: number
		ifPresent: [ :reader | reader value: content ]
		ifAbsent: [ self new number: number; content: content; yourself ]
]

{ #category : #private }
CBORTag class >> readers [
	^ Readers ifNil: [ Readers := Dictionary new ]
]

{ #category : #'instance creation' }
CBORTag class >> selfDescribed: value [
	"Wrap value so that the magic header d9d9f7 preceded it,
	effectively making it self described	(see section 3.4.6 of the RFC)"
	
	^ self number: 55799 content: value
]

{ #category : #comparing }
CBORTag >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ content = anObject content and: [ number = anObject number ]
]

{ #category : #writing }
CBORTag >> cborOn: cborWriter [
	cborWriter writeTag: number content: content
]

{ #category : #accessing }
CBORTag >> content [

	^ content
]

{ #category : #accessing }
CBORTag >> content: anObject [

	content := anObject
]

{ #category : #comparing }
CBORTag >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ content hash bitXor: number hash
]

{ #category : #accessing }
CBORTag >> number [

	^ number
]

{ #category : #accessing }
CBORTag >> number: anObject [

	number := anObject
]

{ #category : #printing }
CBORTag >> printOn: stream [
	super printOn: stream.
	stream 
		nextPut: $(; 
		print: number; 
		nextPut: $,;
		space; 
		print: content; 
		nextPut: $)
]

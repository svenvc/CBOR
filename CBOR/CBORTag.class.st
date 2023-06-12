"
I am CBORTag, a numeric tag as an annotation to some content.

This is an optional extension mechanism. 
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
	"Modification tag 2023-06-12"
	
	self readers
		at: 2 put: [ :content | content asInteger ];
		at: 3 put: [ :content | content asInteger negated - 1 ]
]

{ #category : #'instance creation' }
CBORTag class >> number: number content: content [
	^ self readers 
		at: number
		ifPresent: [ :reader | reader value: content ]
		ifAbsent: [ self new number: number; content: content; yourself ]
]

{ #category : #private }
CBORTag class >> readers [
	^ Readers ifNil: [ Readers := Dictionary new ]
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

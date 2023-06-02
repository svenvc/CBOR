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
	#category : #CBOR
}

{ #category : #'instance creation' }
CBORTag class >> number: number content: content [
	number = 2
		ifTrue: [ ^ content asInteger ].
	number = 3
		ifTrue: [ ^ content asInteger negated - 1 ].		
	^ self new
		number: number;
		content: content;
		yourself
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

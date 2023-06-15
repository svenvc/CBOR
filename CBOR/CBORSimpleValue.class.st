"
I am CBORSimpleValue, holding a number.
"
Class {
	#name : #CBORSimpleValue,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #CBOR
}

{ #category : #'instance creation' }
CBORSimpleValue class >> with: number [
	^ self new number: number; yourself
]

{ #category : #comparing }
CBORSimpleValue >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ number = anObject number
]

{ #category : #writing }
CBORSimpleValue >> cborOn: cborWriter [
	cborWriter writeSimpleValue: number
]

{ #category : #comparing }
CBORSimpleValue >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ number hash
]

{ #category : #accessing }
CBORSimpleValue >> number [

	^ number
]

{ #category : #accessing }
CBORSimpleValue >> number: anObject [

	number := anObject
]

{ #category : #printing }
CBORSimpleValue >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: number; nextPut: $)
]

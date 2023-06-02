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

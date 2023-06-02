"
I am CBORUndefined, a special singleton value.
"
Class {
	#name : #CBORUndefined,
	#superclass : #Object,
	#classVars : [
		'SoleInstance'
	],
	#category : #CBOR
}

{ #category : #accessing }
CBORUndefined class >> soleInstance [
	^ SoleInstance ifNil: [ SoleInstance := self new ]
]

{ #category : #writing }
CBORUndefined >> cborOn: cborWriter [
	cborWriter writeUndefined
]

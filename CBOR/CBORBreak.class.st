"
I am CBORBreak, a special singleton instance.
"
Class {
	#name : #CBORBreak,
	#superclass : #Object,
	#classVars : [
		'SoleInstance'
	],
	#category : #CBOR
}

{ #category : #accessing }
CBORBreak class >> soleInstance [
	^ SoleInstance ifNil: [ SoleInstance := self new ]
]

{ #category : #writing }
CBORBreak >> cborOn: cborWriter [
	cborWriter writeBreak
]

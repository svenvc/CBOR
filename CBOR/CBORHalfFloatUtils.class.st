"
I am CBORHalfFloatUtils, adding encoding/decoding support for the half-precision, IEEE 754 16-bit (binary16) floating-point format.

[https://en.wikipedia.org/wiki/Half-precision_floating-point_format]
"
Class {
	#name : #CBORHalfFloatUtils,
	#superclass : #Object,
	#category : #CBOR
}

{ #category : #utilities }
CBORHalfFloatUtils class >> inRange: float [
	^ float isInfinite or: [ float exponent between: -24 and: 15 ]
]

{ #category : #utilities }
CBORHalfFloatUtils class >> read: halfWord [
	| exponent mantisse value |
	exponent := (halfWord >> 10) bitAnd: 2r11111. "5-bit exponent"
	mantisse := halfWord bitAnd: 2r1111111111. "10-bit mantisse"
	value := exponent = 0
		ifTrue: [ mantisse * (2 ** -24) ]
		ifFalse: [ 
			exponent ~= 2r11111
				ifTrue: [ (mantisse + 1024) * (2 ** (exponent - 25)) ]
				ifFalse: [ mantisse = 0 ifTrue: [ Float infinity ] ifFalse: [ Float nan ] ] ].
	^ (halfWord bitAt: 16) = 1 "1-bit sign"
			ifTrue: [ value asFloat negated ]
			ifFalse: [ value asFloat ]
]

{ #category : #utilities }
CBORHalfFloatUtils class >> write: float [
	| exponent mantisse |
	(exponent := float exponent "11 bits") > 15
		ifTrue: [ (float signBit << 15) + 16r7C00 "infinity" ].
	(float isZero or: [ exponent < -24 ])
		ifTrue: [ ^ float signBit << 15 "0" ].
	float isFinite
		ifFalse: [ ^ float isNaN ifTrue: [ 16r7CFF "NaN" ] ifFalse: [ (float signBit << 15) + 16r7C00 "infinity" ] ].
	mantisse := float significandAsInteger. "52 bits"
	mantisse := (mantisse * (2 ** -42)) rounded. "53/52 -> 11/10 bits"
	exponent := exponent < -14
		ifTrue: [ "subnormal" mantisse := mantisse bitShift: (exponent + 14). 0 ]
		ifFalse: [ (exponent + 15) bitAnd: 2r11111. "5 bits" ].
	^ (float signBit << 15) + (exponent << 10) + (mantisse bitAnd: 2r1111111111)
]

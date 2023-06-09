"
I am CBORFloat16Utils, adding encoding/decoding support for the half-precision, IEEE 754 16-bit (binary16) floating-point format.

https://en.wikipedia.org/wiki/Half-precision_floating-point_format
"
Class {
	#name : #CBORFloat16Utils,
	#superclass : #Object,
	#category : #CBOR
}

{ #category : #utilities }
CBORFloat16Utils class >> inRange: float [
	^ float isInfinite or: [ float exponent between: -14 and: 15 ]
]

{ #category : #utilities }
CBORFloat16Utils class >> read: halfWord [
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
CBORFloat16Utils class >> write: float [
	| signBit exponent mantisse |
	signBit := float signBit. "1 bit"
	float isZero 
		ifTrue: [ ^ signBit << 15 ].
	float isFinite
		ifFalse: [ ^ float isNaN ifTrue: [ 16r7CFF ] ifFalse: [ (signBit << 15) + 16r7C00 "infinity" ] ].
	exponent := float exponent. "11 bits"
	mantisse := float significandAsInteger. "52 bits"
	exponent := (exponent + 15) bitAnd: 2r11111. "5 bits"
	mantisse := (mantisse * (2 ** -42)) truncated. "53/52 -> 11/10 bits"
	(exponent = 1 and: [ (mantisse bitAt: 11) = 0 ])
		ifTrue: [ exponent := 0 "subnormal" ].
	mantisse := mantisse bitAnd: 2r1111111111.
	^ (signBit << 15) + (exponent << 10) + mantisse
]

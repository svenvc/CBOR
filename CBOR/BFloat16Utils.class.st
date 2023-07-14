"
I am BFloat16Utils, adding encoding/decoding support for the bfloat16 (brain floating point) 16-bit floating-point format.

This format has 1 sign bit, an 8 bit exponent and a 7 bit significant. This means it has the same overall range as 32 bit floating point with less precision. 

[https://en.wikipedia.org/wiki/Bfloat16_floating-point_format]
"
Class {
	#name : #BFloat16Utils,
	#superclass : #Object,
	#category : #CBOR
}

{ #category : #utilities }
BFloat16Utils class >> inRange: float [
	^ float isInfinite or: [ float exponent between: -133 and: 127 ]
]

{ #category : #utilities }
BFloat16Utils class >> read: halfWord [
	| exponent mantisse value |
	exponent := (halfWord >> 7) bitAnd: 2r11111111. "8-bit exponent"
	mantisse := halfWord bitAnd: 2r1111111. "7-bit mantisse"
	value := exponent = 0
		ifTrue: [ mantisse * (2 ** -133) ]
		ifFalse: [ 
			exponent ~= 2r11111111
				ifTrue: [ (mantisse + 128) * (2 ** (exponent - 134)) ]
				ifFalse: [ mantisse = 0 ifTrue: [ Float infinity ] ifFalse: [ Float nan ] ] ].
	^ (halfWord bitAt: 16) = 1 "1-bit sign"
			ifTrue: [ value asFloat negated ]
			ifFalse: [ value asFloat ]
]

{ #category : #utilities }
BFloat16Utils class >> write: float [
	| exponent mantisse |
	(exponent := float exponent "11 bits") > 127
		ifTrue: [ (float signBit << 15) + 16r7F80 "infinity" ].
	(float isZero or: [ exponent < -133 ])
		ifTrue: [ ^ float signBit << 15 "0" ].
	float isFinite
		ifFalse: [ ^ float isNaN ifTrue: [ 16rFFFF "NaN" ] ifFalse: [ (float signBit << 15) + 16r7F80 "infinity" ] ].
	mantisse := float significandAsInteger. "52 bits"
	mantisse := (mantisse * (2 ** -45)) rounded. "53/52 -> 8/7 bits"
	exponent := exponent < -126
		ifTrue: [ "subnormal" mantisse := mantisse bitShift: (exponent + 126). 0 ]
		ifFalse: [ (exponent + 127) bitAnd: 2r11111111. "8 bits" ].
	^ (float signBit << 15) + (exponent << 7) + (mantisse bitAnd: 2r1111111)
]

Class {
	#name : #HalfFloatUtilsTest,
	#superclass : #TestCase,
	#category : #'CBOR-Tests'
}

{ #category : #tests }
HalfFloatUtilsTest >> testFloat16Decoding [
	#(
		(16r0000 0.0) (16r0001 0.000000059604645) (16r03ff 0.000060975552)
		(16r0400 0.00006103515625) (16r3555 0.33325195 ) (16r3bff 0.99951172)
		(16r3c00 1.0) (16r3c01 1.00097656) (16r7bff 65504.0) (16r8000 -0.0) (16rc000 -2.0) )
		,
	{ { 16r7c00 . Float infinity } . { 16rfc00 . Float infinity negated } } do: [ :spec | 
			self 
				assert: (HalfFloatUtils read: spec first) 
				closeTo: spec second 
				precision: 0.01 ]
]

{ #category : #tests }
HalfFloatUtilsTest >> testFloat16Encoding [
	#(
		(16r0000 0.0) (16r0001 0.000000059604645) (16r03ff 0.000060975552)
		(16r0400 0.00006103515625) (16r3555 0.33325195 ) (16r3bff 0.99951172)
		(16r3c00 1.0) (16r3c01 1.00097656) (16r7bff 65504.0) (16r8000 -0.0) (16rc000 -2.0) )
		,
	{ { 16r7c00 . Float infinity } . { 16rfc00 . Float infinity negated } } do: [ :spec | 
			self 
				assert: (HalfFloatUtils write: spec second) 
				equals: spec first ]
]

{ #category : #tests }
HalfFloatUtilsTest >> testFloat16EncodingDecoding [
	{
		1.0 . -1.0 . 0.0 . 
		100.0 . 1000.0 . 10000.0 .
		-1.5 . -1.05. 7.5 .
		Float pi. Float e. (1/3) asFloat } do: [ :float | | encoded decoded |
			encoded := HalfFloatUtils write: float.
			decoded := HalfFloatUtils read: encoded.
			self assert: decoded closeTo: float precision: 0.01 ]
]

Class {
	#name : #BFloat16UtilsTest,
	#superclass : #TestCase,
	#category : #'CBOR-Tests'
}

{ #category : #tests }
BFloat16UtilsTest >> examples [
	^ {
	16r3F80 -> 1.0.
	16rC000 -> -2.0.
	16r4049 -> 3.140625.
	16r3EAB -> 0.333984375.
	16r402E -> 2.71875.
	16r0000 -> 0.0.
	16r8000 -> -0.0.
	16r7F80 -> Float infinity.
	16rFF80 -> Float infinity negated.
	16r0001 -> (2 ** -133) asFloat.
	16r0D80 -> (2 ** -100) asFloat.
	}
]

{ #category : #tests }
BFloat16UtilsTest >> testInRange [
	self examples do: [ :each |
		self assert: (BFloat16Utils inRange: each value) ].
	self assert: (BFloat16Utils inRange: Float nan).
	self deny: (BFloat16Utils inRange: 1.0e200).
	self deny: (BFloat16Utils inRange: 1.0e-200).
]

{ #category : #tests }
BFloat16UtilsTest >> testNaN [
	self assert: (BFloat16Utils read: 16rFFFF) isNaN.
	self assert: (BFloat16Utils write: Float nan) equals: 16rFFFF.
]

{ #category : #tests }
BFloat16UtilsTest >> testReadWrite [
	self examples do: [ :spec | | encoding float |
		encoding := spec key.
		float := spec value.
		self assert: (BFloat16Utils read: encoding) equals: float.
		self assert: (BFloat16Utils write: float) equals: encoding ]
]

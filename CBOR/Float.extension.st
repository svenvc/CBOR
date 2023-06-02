Extension { #name : #Float }

{ #category : #'*CBOR' }
Float >> cborOn: cborWriter [
	cborWriter writeFloat: self
]

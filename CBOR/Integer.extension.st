Extension { #name : #Integer }

{ #category : #'*CBOR' }
Integer >> cborOn: cborWriter [
	cborWriter writeInteger: self
]

Extension { #name : #Object }

{ #category : #'*CBOR' }
Object >> cborOn: cborWriter [
	cborWriter writeObject: self
]

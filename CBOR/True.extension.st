Extension { #name : #True }

{ #category : #'*CBOR' }
True >> cborOn: cborWriter [
	cborWriter writeTrue
]

Extension { #name : #Dictionary }

{ #category : #'*CBOR' }
Dictionary >> cborOn: cborWriter [
	cborWriter writeMap: self
]

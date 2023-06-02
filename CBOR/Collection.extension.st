Extension { #name : #Collection }

{ #category : #'*CBOR' }
Collection >> cborOn: cborWriter [
	cborWriter writeList: self
]

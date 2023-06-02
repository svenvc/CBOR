Extension { #name : #False }

{ #category : #'*CBOR' }
False >> cborOn: cborWriter [
	cborWriter writeFalse
]

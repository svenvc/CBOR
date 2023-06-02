Extension { #name : #UndefinedObject }

{ #category : #'*CBOR' }
UndefinedObject >> cborOn: cborWriter [
	cborWriter writeNull
]

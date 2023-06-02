Extension { #name : #OrderedDictionary }

{ #category : #'*CBOR' }
OrderedDictionary >> cborOn: cborWriter [
	cborWriter writeMap: self
]

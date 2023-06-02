Extension { #name : #String }

{ #category : #'*CBOR' }
String >> cborOn: cborWriter [
	cborWriter writeString: self
]

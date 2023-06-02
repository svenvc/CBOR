Extension { #name : #ByteArray }

{ #category : #'*CBOR' }
ByteArray >> cborOn: cborWriter [
	cborWriter writeBytes: self
]

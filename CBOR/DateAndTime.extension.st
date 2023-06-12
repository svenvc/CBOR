Extension { #name : #DateAndTime }

{ #category : #'*CBOR' }
DateAndTime >> cborOn: cborWriter [
	cborWriter writeTag: 0 content: self printString
]

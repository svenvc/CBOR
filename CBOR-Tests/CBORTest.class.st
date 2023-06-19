Class {
	#name : #CBORTest,
	#superclass : #TestCase,
	#category : #'CBOR-Tests'
}

{ #category : #accessing }
CBORTest >> appendixADataOrdered [
	^ (NeoJSONReader on: self appendixAJson readStream) 
			mapClass: OrderedDictionary;
			next
]

{ #category : #accessing }
CBORTest >> appendixAJson [
	"'https://github.com/cbor/test-vectors/raw/master/appendix_a.json' asUrl retrieveContents"
	
	^ '[
  {
    "cbor": "AA==",
    "hex": "00",
    "roundtrip": true,
    "decoded": 0
  },
  {
    "cbor": "AQ==",
    "hex": "01",
    "roundtrip": true,
    "decoded": 1
  },
  {
    "cbor": "Cg==",
    "hex": "0a",
    "roundtrip": true,
    "decoded": 10
  },
  {
    "cbor": "Fw==",
    "hex": "17",
    "roundtrip": true,
    "decoded": 23
  },
  {
    "cbor": "GBg=",
    "hex": "1818",
    "roundtrip": true,
    "decoded": 24
  },
  {
    "cbor": "GBk=",
    "hex": "1819",
    "roundtrip": true,
    "decoded": 25
  },
  {
    "cbor": "GGQ=",
    "hex": "1864",
    "roundtrip": true,
    "decoded": 100
  },
  {
    "cbor": "GQPo",
    "hex": "1903e8",
    "roundtrip": true,
    "decoded": 1000
  },
  {
    "cbor": "GgAPQkA=",
    "hex": "1a000f4240",
    "roundtrip": true,
    "decoded": 1000000
  },
  {
    "cbor": "GwAAAOjUpRAA",
    "hex": "1b000000e8d4a51000",
    "roundtrip": true,
    "decoded": 1000000000000
  },
  {
    "cbor": "G///////////",
    "hex": "1bffffffffffffffff",
    "roundtrip": true,
    "decoded": 18446744073709551615
  },
  {
    "cbor": "wkkBAAAAAAAAAAA=",
    "hex": "c249010000000000000000",
    "roundtrip": true,
    "decoded": 18446744073709551616
  },
  {
    "cbor": "O///////////",
    "hex": "3bffffffffffffffff",
    "roundtrip": true,
    "decoded": -18446744073709551616
  },
  {
    "cbor": "w0kBAAAAAAAAAAA=",
    "hex": "c349010000000000000000",
    "roundtrip": true,
    "decoded": -18446744073709551617
  },
  {
    "cbor": "IA==",
    "hex": "20",
    "roundtrip": true,
    "decoded": -1
  },
  {
    "cbor": "KQ==",
    "hex": "29",
    "roundtrip": true,
    "decoded": -10
  },
  {
    "cbor": "OGM=",
    "hex": "3863",
    "roundtrip": true,
    "decoded": -100
  },
  {
    "cbor": "OQPn",
    "hex": "3903e7",
    "roundtrip": true,
    "decoded": -1000
  },
  {
    "cbor": "+QAA",
    "hex": "f90000",
    "roundtrip": true,
    "decoded": 0.0
  },
  {
    "cbor": "+YAA",
    "hex": "f98000",
    "roundtrip": true,
    "decoded": -0.0
  },
  {
    "cbor": "+TwA",
    "hex": "f93c00",
    "roundtrip": true,
    "decoded": 1.0
  },
  {
    "cbor": "+z/xmZmZmZma",
    "hex": "fb3ff199999999999a",
    "roundtrip": true,
    "decoded": 1.1
  },
  {
    "cbor": "+T4A",
    "hex": "f93e00",
    "roundtrip": true,
    "decoded": 1.5
  },
  {
    "cbor": "+Xv/",
    "hex": "f97bff",
    "roundtrip": true,
    "decoded": 65504.0
  },
  {
    "cbor": "+kfDUAA=",
    "hex": "fa47c35000",
    "roundtrip": true,
    "decoded": 100000.0
  },
  {
    "cbor": "+n9///8=",
    "hex": "fa7f7fffff",
    "roundtrip": true,
    "decoded": 3.4028234663852886e+38
  },
  {
    "cbor": "+3435DyIAHWc",
    "hex": "fb7e37e43c8800759c",
    "roundtrip": true,
    "decoded": 1.0e+300
  },
  {
    "cbor": "+QAB",
    "hex": "f90001",
    "roundtrip": true,
    "decoded": 5.960464477539063e-08
  },
  {
    "cbor": "+QQA",
    "hex": "f90400",
    "roundtrip": true,
    "decoded": 6.103515625e-05
  },
  {
    "cbor": "+cQA",
    "hex": "f9c400",
    "roundtrip": true,
    "decoded": -4.0
  },
  {
    "cbor": "+8AQZmZmZmZm",
    "hex": "fbc010666666666666",
    "roundtrip": true,
    "decoded": -4.1
  },
  {
    "cbor": "+XwA",
    "hex": "f97c00",
    "roundtrip": true,
    "diagnostic": "Infinity"
  },
  {
    "cbor": "+X4A",
    "hex": "f97e00",
    "roundtrip": true,
    "diagnostic": "NaN"
  },
  {
    "cbor": "+fwA",
    "hex": "f9fc00",
    "roundtrip": true,
    "diagnostic": "-Infinity"
  },
  {
    "cbor": "+n+AAAA=",
    "hex": "fa7f800000",
    "roundtrip": false,
    "diagnostic": "Infinity"
  },
  {
    "cbor": "+n/AAAA=",
    "hex": "fa7fc00000",
    "roundtrip": false,
    "diagnostic": "NaN"
  },
  {
    "cbor": "+v+AAAA=",
    "hex": "faff800000",
    "roundtrip": false,
    "diagnostic": "-Infinity"
  },
  {
    "cbor": "+3/wAAAAAAAA",
    "hex": "fb7ff0000000000000",
    "roundtrip": false,
    "diagnostic": "Infinity"
  },
  {
    "cbor": "+3/4AAAAAAAA",
    "hex": "fb7ff8000000000000",
    "roundtrip": false,
    "diagnostic": "NaN"
  },
  {
    "cbor": "+//wAAAAAAAA",
    "hex": "fbfff0000000000000",
    "roundtrip": false,
    "diagnostic": "-Infinity"
  },
  {
    "cbor": "9A==",
    "hex": "f4",
    "roundtrip": true,
    "decoded": false
  },
  {
    "cbor": "9Q==",
    "hex": "f5",
    "roundtrip": true,
    "decoded": true
  },
  {
    "cbor": "9g==",
    "hex": "f6",
    "roundtrip": true,
    "decoded": null
  },
  {
    "cbor": "9w==",
    "hex": "f7",
    "roundtrip": true,
    "diagnostic": "undefined"
  },
  {
    "cbor": "8A==",
    "hex": "f0",
    "roundtrip": true,
    "diagnostic": "simple(16)"
  },
  {
    "cbor": "+Bg=",
    "hex": "f818",
    "roundtrip": true,
    "diagnostic": "simple(24)"
  },
  {
    "cbor": "+P8=",
    "hex": "f8ff",
    "roundtrip": true,
    "diagnostic": "simple(255)"
  },
  {
    "cbor": "wHQyMDEzLTAzLTIxVDIwOjA0OjAwWg==",
    "hex": "c074323031332d30332d32315432303a30343a30305a",
    "roundtrip": true,
    "diagnostic": "0(\"2013-03-21T20:04:00Z\")"
  },
  {
    "cbor": "wRpRS2ew",
    "hex": "c11a514b67b0",
    "roundtrip": true,
    "diagnostic": "1(1363896240)"
  },
  {
    "cbor": "wftB1FLZ7CAAAA==",
    "hex": "c1fb41d452d9ec200000",
    "roundtrip": true,
    "diagnostic": "1(1363896240.5)"
  },
  {
    "cbor": "10QBAgME",
    "hex": "d74401020304",
    "roundtrip": true,
    "diagnostic": "23(h''01020304'')"
  },
  {
    "cbor": "2BhFZElFVEY=",
    "hex": "d818456449455446",
    "roundtrip": true,
    "diagnostic": "24(h''6449455446'')"
  },
  {
    "cbor": "2CB2aHR0cDovL3d3dy5leGFtcGxlLmNvbQ==",
    "hex": "d82076687474703a2f2f7777772e6578616d706c652e636f6d",
    "roundtrip": true,
    "diagnostic": "32(\"http://www.example.com\")"
  },
  {
    "cbor": "QA==",
    "hex": "40",
    "roundtrip": true,
    "diagnostic": "h''''"
  },
  {
    "cbor": "RAECAwQ=",
    "hex": "4401020304",
    "roundtrip": true,
    "diagnostic": "h''01020304''"
  },
  {
    "cbor": "YA==",
    "hex": "60",
    "roundtrip": true,
    "decoded": ""
  },
  {
    "cbor": "YWE=",
    "hex": "6161",
    "roundtrip": true,
    "decoded": "a"
  },
  {
    "cbor": "ZElFVEY=",
    "hex": "6449455446",
    "roundtrip": true,
    "decoded": "IETF"
  },
  {
    "cbor": "YiJc",
    "hex": "62225c",
    "roundtrip": true,
    "decoded": "\"\\"
  },
  {
    "cbor": "YsO8",
    "hex": "62c3bc",
    "roundtrip": true,
    "decoded": "ü"
  },
  {
    "cbor": "Y+awtA==",
    "hex": "63e6b0b4",
    "roundtrip": true,
    "decoded": "水"
  },
  {
    "cbor": "ZPCQhZE=",
    "hex": "64f0908591",
    "roundtrip": true,
    "decoded": "𐅑"
  },
  {
    "cbor": "gA==",
    "hex": "80",
    "roundtrip": true,
    "decoded": [

    ]
  },
  {
    "cbor": "gwECAw==",
    "hex": "83010203",
    "roundtrip": true,
    "decoded": [
      1,
      2,
      3
    ]
  },
  {
    "cbor": "gwGCAgOCBAU=",
    "hex": "8301820203820405",
    "roundtrip": true,
    "decoded": [
      1,
      [
        2,
        3
      ],
      [
        4,
        5
      ]
    ]
  },
  {
    "cbor": "mBkBAgMEBQYHCAkKCwwNDg8QERITFBUWFxgYGBk=",
    "hex": "98190102030405060708090a0b0c0d0e0f101112131415161718181819",
    "roundtrip": true,
    "decoded": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25
    ]
  },
  {
    "cbor": "oA==",
    "hex": "a0",
    "roundtrip": true,
    "decoded": {
    }
  },
  {
    "cbor": "ogECAwQ=",
    "hex": "a201020304",
    "roundtrip": true,
    "diagnostic": "{1: 2, 3: 4}"
  },
  {
    "cbor": "omFhAWFiggID",
    "hex": "a26161016162820203",
    "roundtrip": true,
    "decoded": {
      "a": 1,
      "b": [
        2,
        3
      ]
    }
  },
  {
    "cbor": "gmFhoWFiYWM=",
    "hex": "826161a161626163",
    "roundtrip": true,
    "decoded": [
      "a",
      {
        "b": "c"
      }
    ]
  },
  {
    "cbor": "pWFhYUFhYmFCYWNhQ2FkYURhZWFF",
    "hex": "a56161614161626142616361436164614461656145",
    "roundtrip": true,
    "decoded": {
      "a": "A",
      "b": "B",
      "c": "C",
      "d": "D",
      "e": "E"
    }
  },
  {
    "cbor": "X0IBAkMDBAX/",
    "hex": "5f42010243030405ff",
    "roundtrip": false,
    "diagnostic": "(_ h''0102'', h''030405'')"
  },
  {
    "cbor": "f2VzdHJlYWRtaW5n/w==",
    "hex": "7f657374726561646d696e67ff",
    "roundtrip": false,
    "decoded": "streaming"
  },
  {
    "cbor": "n/8=",
    "hex": "9fff",
    "roundtrip": false,
    "decoded": [

    ]
  },
  {
    "cbor": "nwGCAgOfBAX//w==",
    "hex": "9f018202039f0405ffff",
    "roundtrip": false,
    "decoded": [
      1,
      [
        2,
        3
      ],
      [
        4,
        5
      ]
    ]
  },
  {
    "cbor": "nwGCAgOCBAX/",
    "hex": "9f01820203820405ff",
    "roundtrip": false,
    "decoded": [
      1,
      [
        2,
        3
      ],
      [
        4,
        5
      ]
    ]
  },
  {
    "cbor": "gwGCAgOfBAX/",
    "hex": "83018202039f0405ff",
    "roundtrip": false,
    "decoded": [
      1,
      [
        2,
        3
      ],
      [
        4,
        5
      ]
    ]
  },
  {
    "cbor": "gwGfAgP/ggQF",
    "hex": "83019f0203ff820405",
    "roundtrip": false,
    "decoded": [
      1,
      [
        2,
        3
      ],
      [
        4,
        5
      ]
    ]
  },
  {
    "cbor": "nwECAwQFBgcICQoLDA0ODxAREhMUFRYXGBgYGf8=",
    "hex": "9f0102030405060708090a0b0c0d0e0f101112131415161718181819ff",
    "roundtrip": false,
    "decoded": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25
    ]
  },
  {
    "cbor": "v2FhAWFinwID//8=",
    "hex": "bf61610161629f0203ffff",
    "roundtrip": false,
    "decoded": {
      "a": 1,
      "b": [
        2,
        3
      ]
    }
  },
  {
    "cbor": "gmFhv2FiYWP/",
    "hex": "826161bf61626163ff",
    "roundtrip": false,
    "decoded": [
      "a",
      {
        "b": "c"
      }
    ]
  },
  {
    "cbor": "v2NGdW71Y0FtdCH/",
    "hex": "bf6346756ef563416d7421ff",
    "roundtrip": false,
    "decoded": {
      "Fun": true,
      "Amt": -2
    }
  }
]
'
]

{ #category : #tests }
CBORTest >> testBytes [
	| data encoded decoded |
	data := { #[1 2 3]. #[]. #[0 255 0 255] }.
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data
]

{ #category : #tests }
CBORTest >> testCBORUndefined [
	| data encoded decoded |
	data := { CBORUndefined soleInstance. nil. CBORUndefined soleInstance }.
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data
]

{ #category : #tests }
CBORTest >> testDateAndTime [
	| now data encoded decoded |
	now := DateAndTime now.
	data := { now. CBORTag new number: 1; content: now asUnixTime; yourself }.
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: { now. now truncated }
]

{ #category : #tests }
CBORTest >> testFloat16Decoding [
	#(
		(16r0000 0.0) (16r0001 0.000000059604645) (16r03ff 0.000060975552)
		(16r0400 0.00006103515625) (16r3555 0.33325195 ) (16r3bff 0.99951172)
		(16r3c00 1.0) (16r3c01 1.00097656) (16r7bff 65504.0) (16r8000 -0.0) (16rc000 -2.0) )
		,
	{ { 16r7c00 . Float infinity } . { 16rfc00 . Float infinity negated } } do: [ :spec | 
			self 
				assert: (CBORFloat16Utils read: spec first) 
				closeTo: spec second 
				precision: 0.01 ]
]

{ #category : #tests }
CBORTest >> testFloat16Encoding [
	#(
		(16r0000 0.0) "(16r0001 0.000000059604645)" "(16r03ff 0.000060975552)"
		(16r0400 0.00006103515625) (16r3555 0.33325195 ) (16r3bff 0.99951172)
		(16r3c00 1.0) (16r3c01 1.00097656) (16r7bff 65504.0) (16r8000 -0.0) (16rc000 -2.0) )
		,
	{ { 16r7c00 . Float infinity } . { 16rfc00 . Float infinity negated } } do: [ :spec | 
			self 
				assert: (CBORFloat16Utils write: spec second) 
				equals: spec first ]
]

{ #category : #tests }
CBORTest >> testFloat16EncodingDecoding [
	{
		1.0 . -1.0 . 0.0 . 
		100.0 . 1000.0 . 10000.0 .
		-1.5 . -1.05. 7.5 .
		Float pi. Float e. (1/3) asFloat } do: [ :float | | encoded decoded |
			encoded := CBORFloat16Utils write: float.
			decoded := CBORFloat16Utils read: encoded.
			self assert: decoded closeTo: float precision: 0.01 ]
]

{ #category : #tests }
CBORTest >> testFloats [
	| data encoded decoded |
	data := {
		1.0 . -1.0 . 0.0 . 
		100.0 . 1000.0 . 10000.0 .
		-1.5 . -1.05. 7.5 .
		Float pi. Float e. (1/3) asFloat }.
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	data with: decoded do: [ :in :out |
		self assert: out closeTo: in precision: 0.01 ]
]

{ #category : #tests }
CBORTest >> testIntegers [
	| data encoded decoded |
	data := #(0 1 -1 100 1000 10000 -100 -1000 -10000).
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data
]

{ #category : #tests }
CBORTest >> testLargeIntegers [
	| data encoded decoded |
	data := { 
		SmallInteger maxVal. SmallInteger maxVal negated. 
		1e64. -1e64. 
		-18446744073709551617. 18446744073709551616 }.
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data
]

{ #category : #tests }
CBORTest >> testLists [
	| data encoded decoded |
	data := #((1 2 3) (-1 -2 -3) (123456 -123456) ('A' 'ü') () (()) (true false) (nil)).
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data
]

{ #category : #tests }
CBORTest >> testMaps [
	| data encoded decoded |
	data := {
		'small' -> ({ 'one'->1. 'two'->2. 'three'->3 } as: OrderedDictionary).
		'large' -> ({ 'positive'->123456. 'negative'->(-123456) } as: OrderedDictionary).
		'empty' -> OrderedDictionary new.
		'special' -> ({ 'true'->true. 'false'->false. 'nil'->nil } as: OrderedDictionary) } as: OrderedDictionary.
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data
]

{ #category : #tests }
CBORTest >> testMapsUnOrdered [
	| data encoded decoded |
	data := { 'one'->1. 'two'->2. 'three'->3 } as: Dictionary.
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	data keysAndValuesDo: [ :key :value |
		self assert: (decoded at: key) equals: value  ]
]

{ #category : #tests }
CBORTest >> testReadingAppendixA [
	self appendixADataOrdered do: [ :each | | input output |
		input := ByteArray readHexFrom: (each at: #hex).
		output := (CBORReader on: input readStream) next.
		each at: #decoded ifPresent: [ :decoded |
			decoded isFloat
				ifTrue: [ self assert: output closeTo: decoded ]
				ifFalse: [ self assert: output equals: decoded ] ] ]
]

{ #category : #tests }
CBORTest >> testSelfDescribed [
	| data encoded decoded |
	data := CBORTag selfDescribed: #(0 1 42).
	encoded := CBORWriter encode: data.
	self assert: (encoded beginsWith: (ByteArray readHexFrom: 'd9d9f7')).
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data.
	self assert: decoded content equals: #(0 1 42)
]

{ #category : #tests }
CBORTest >> testSimpleValues [
	| data encoded decoded |
	data := { CBORSimpleValue with: 7. CBORSimpleValue with: 42. CBORSimpleValue with: 240 }.
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data
]

{ #category : #tests }
CBORTest >> testStrings [
	| data encoded decoded |
	data := #('abc' 'ABC' 'élève en Français' '' '''' '"' 'X') 
					, { Character alphabet. String loremIpsum }. 
	encoded := CBORWriter encode: data.
	decoded := CBORReader decode: encoded.
	self assert: decoded equals: data
]

{ #category : #tests }
CBORTest >> testWritingAppendixA [
	self appendixADataOrdered withIndexDo: [ :each : index |
		(#(28) includes: index) 
			ifFalse: [ 
				each at: #decoded ifPresent: [ :decoded |
					(each at: #roundtrip)
						ifTrue: [ | expected output |
							expected := ByteArray readHexFrom: (each at: #hex).
							output := ByteArray streamContents: [ :out |
								(CBORWriter on: out) nextPut: decoded ].
							self assert: output equals: expected ] ] ] ]
]

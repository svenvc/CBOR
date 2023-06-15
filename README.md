# CBOR

[![CI](https://github.com/svenvc/CBOR/actions/workflows/CI.yml/badge.svg)](https://github.com/svenvc/CBOR/actions/workflows/CI.yml)

Concise Binary Object Representation for Pharo

Concise Binary Object Representation (CBOR) is a binary data serialization format. 
CBOR is based on the JSON data model: a number of primitive types, list and maps (which represent objects or structures).
Being binary, CBOR is more efficient than JSON, which is text based.
CBOR also supports binary data and optional extensions (called tags).

This project contains encoding/decoding support for the half-precision, IEEE 754 16-bit (binary16) floating-point format.

## Examples

```Smalltalk
(CBORReader on: (ByteArray readHexFrom: 'a201020304') readStream) next.

CBORReader decode: #[162 1 2 3 4].

ByteArray streamContents: [ :out | (CBORWriter on: out) nextPut: { 1 -> 2. 3 -> 4 } asDictionary ].

CBORWriter encode: { 1 -> 2. 3 -> 4 } asOrderedDictionary.
```

## References

- https://en.wikipedia.org/wiki/CBOR
- https://cbor.io
- https://www.rfc-editor.org/rfc/rfc8949.html

## Installation

This is a [Pharo Smalltalk](http://wwww.pharo.st) project 
using the [Tonel](https://github.com/pharo-vcs/tonel) source code format.

In Pharo 10 and up you can use Iceberg to load this project.

You can also load using the following expression:

    Metacello new
      baseline: 'CBOR';
      repository: 'github://svenvc/CBOR';
      load.
   
Written and supported by Sven Van Caekenberghe. MIT Licensed.

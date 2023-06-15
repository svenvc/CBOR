"
I am BaselineOfCBOR, I help loading the CBOR package.
I am a BaselineOf.

Concise Binary Object Representation (CBOR) is a binary data serialization format based on JSON data model.

References:

-	https://en.wikipedia.org/wiki/CBOR
-	https://cbor.io
-	https://www.rfc-editor.org/rfc/rfc8949.html
"
Class {
	#name : #BaselineOfCBOR,
	#superclass : #BaselineOf,
	#category : #BaselineOfCBOR
}

{ #category : #baselines }
BaselineOfCBOR >> baseline: spec [
	<baseline> 
	
	spec for: #common do: [
		spec
			baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ];
			package: 'CBOR';
			package: 'CBOR-Tests' with: [ spec requires: #('CBOR' 'NeoJSON') ];
			group: 'default' with: #('core' 'tests');
			group: 'core' with: #('CBOR');
			group: 'tests' with: #('CBOR-Tests') ]
]

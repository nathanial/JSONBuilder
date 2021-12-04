Class {
	#name : #JsonBuilderTests,
	#superclass : #TestCase,
	#category : #JsonBuilder
}

{ #category : #tests }
JsonBuilderTests >> testArrayNesting [
	|b|
	b := JsonBuilder new.
	b at: 'stuff' array: [ 		
		1 to: 2 do: [ :i |
			b array: [
				b value: 1.
				b value: 2.
			].
		].
	].
	self assert: b toJsonString equals: '{"stuff":[[1,2],[1,2]]}'.
]

{ #category : #tests }
JsonBuilderTests >> testArrayObjectNesting [
	|b|
	b := JsonBuilder new.
	b at: 'stuff' array: [
		1 to: 2 do: [ :i |
			b object: [ 
				b at: 'a' object: [
					b at:'a1' put: 'madness'.
				].
				b at: 'b' object: [ 
					b at: 'b1' put: 1.
					b at: 'b2' put: 2.
				].
			].
		].
	].
	self assert: b toJsonString equals: '{"stuff":[{"a":{"a1":"madness"},"b":{"b2":2,"b1":1}},{"a":{"a1":"madness"},"b":{"b2":2,"b1":1}}]}'.
]

{ #category : #tests }
JsonBuilderTests >> testNesting [
	|b|
	b := JsonBuilder new.
	b at: 'foo' put: '1'.
	b at: 'bar' object: [ 
		b at: 'baz' put: 2.
	].
	self assert: b toJsonString equals: '{"foo":"1","bar":{"baz":2}}'.
]

{ #category : #tests }
JsonBuilderTests >> testNumber [
	|b|
	b := JsonBuilder new.
	b at: 'foo' put: 1.
	self assert: b toJsonString equals: '{"foo":1}'.
]

{ #category : #tests }
JsonBuilderTests >> testString [
	|b|
	b := JsonBuilder new.
	b at: 'foo' put: '1'.
	self assert: b toJsonString equals: '{"foo":"1"}'.
]

{ #category : #tests }
JsonBuilderTests >> testTrivialExample [
	|b|
	b := JsonBuilder new.
	self assert: b toJsonString equals: '{}'.
]

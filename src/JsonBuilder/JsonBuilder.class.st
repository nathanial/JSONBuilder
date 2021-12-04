Class {
	#name : #JsonBuilder,
	#superclass : #Object,
	#instVars : [
		'root',
		'cursor'
	],
	#category : #JsonBuilder
}

{ #category : #accessing }
JsonBuilder >> array: aBlock [
	|before|
	before := cursor.
	cursor := OrderedCollection new.
	aBlock value.
	before add: cursor asArray.
	cursor := before.
]

{ #category : #accessing }
JsonBuilder >> at: aProp array: aBlock [ 
	|nested before|
	before := cursor.
	nested := OrderedCollection new.
	cursor := nested.
	aBlock value.
	cursor := before.
	cursor at: aProp put: nested asArray.
]

{ #category : #accessing }
JsonBuilder >> at: aProp object: aBlock [ 
	|nested before|
	before := cursor.	
	nested := Dictionary new.
	cursor := nested.	
	aBlock value.
	cursor := before.

	(cursor isKindOf: OrderedCollection) ifTrue: [ 
		cursor add: { aProp -> nested } asDictionary.
	] ifFalse: [ 
		cursor at: aProp put: nested.
 	].
	
]

{ #category : #accessing }
JsonBuilder >> at: aProp put: aValue [
	(cursor isKindOf: OrderedCollection) ifTrue: [ 
		|newObj|
		newObj := Dictionary new.		
		cursor add: newObj .
		newObj at: aProp put: aValue.		
	] ifFalse: [ 
		cursor at: aProp put: aValue
 	].

]

{ #category : #accessing }
JsonBuilder >> initialize [
	super initialize.
	root := Dictionary new.
	cursor := root.
]

{ #category : #accessing }
JsonBuilder >> object: aBlock [
	|before|
	before := cursor.
	cursor := Dictionary new.
	aBlock value.
	before add: cursor.
	cursor := before.
]

{ #category : #accessing }
JsonBuilder >> toJsonString [
	^ NeoJSONWriter toString: root deepCopy 
]

{ #category : #accessing }
JsonBuilder >> toPrettyJsonString [
	^ NeoJSONWriter toStringPretty: root deepCopy
]

{ #category : #accessing }
JsonBuilder >> value: aValue [
	cursor add: aValue
]

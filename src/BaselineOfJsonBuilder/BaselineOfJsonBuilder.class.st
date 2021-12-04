Class {
	#name : #BaselineOfJsonBuilder,
	#superclass : #BaselineOf,
	#category : #BaselineOfJsonBuilder
}

{ #category : #baselines }
BaselineOfJsonBuilder >> baseline: spec [
	<baseline>
	spec 
		for: #common
		do: [ 
			spec package: 'JsonBuilder'
		]
]

Class {
	#name : #MarvinOtlCategoryLabel,
	#superclass : #MarvinOtlComponent,
	#instVars : [
		'labelMorph'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlCategoryLabel >> initialize [

	super initialize.

	self labelMorph: 	'category' asMorph.

	self addMorph: self labelMorph.
]

{ #category : #accessing }
MarvinOtlCategoryLabel >> labelMorph [
	^labelMorph
]

{ #category : #accessing }
MarvinOtlCategoryLabel >> labelMorph: anObject [
	labelMorph := anObject
]

{ #category : #'as yet unclassified' }
MarvinOtlCategoryLabel >> optimalWidth [

	^ self labelMorph width
]

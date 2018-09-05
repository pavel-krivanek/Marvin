Class {
	#name : #MarvinOtlComponent,
	#superclass : #BorderedMorph,
	#instVars : [
		'outliner',
		'model'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlComponent class >> outliner: anOutliner [

	self new outliner: anOutliner.

]

{ #category : #accessing }
MarvinOtlComponent >> adjustWidth [

	 outliner ifNotNilDo: [:otl | otl  adjustWidth]

]

{ #category : #accessing }
MarvinOtlComponent >> adjustWidth: aNumber [

	self width: aNumber
]

{ #category : #accessing }
MarvinOtlComponent >> initialize [

	super initialize.

	self borderWidth: 0.
	self color:  (Color r: 0.935 g: 0.935 b: 0.0871).

	self height: self minHeight.

]

{ #category : #accessing }
MarvinOtlComponent >> minHeight [

	^ 16
]

{ #category : #accessing }
MarvinOtlComponent >> model [

	^ model
]

{ #category : #accessing }
MarvinOtlComponent >> model: aModel [

	model := aModel
]

{ #category : #accessing }
MarvinOtlComponent >> optimalWidth [

	^ 70
]

{ #category : #accessing }
MarvinOtlComponent >> outliner [
	^outliner
]

{ #category : #accessing }
MarvinOtlComponent >> outliner: anObject [
	outliner := anObject
]

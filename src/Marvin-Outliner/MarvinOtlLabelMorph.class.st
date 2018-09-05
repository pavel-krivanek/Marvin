Class {
	#name : #MarvinOtlLabelMorph,
	#superclass : #Morph,
	#instVars : [
		'name',
		'menuAction',
		'stringMorph'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlLabelMorph class >> new [ 

	^ super new name: ''
]

{ #category : #'as yet unclassified' }
MarvinOtlLabelMorph >> handlesMouseDown: evt [

	^ true
]

{ #category : #'as yet unclassified' }
MarvinOtlLabelMorph >> initialize [

	super initialize.

	stringMorph := StringMorph new.
	self addMorph: stringMorph.
	self color: Color transparent.
]

{ #category : #accessing }
MarvinOtlLabelMorph >> menuAction [

	^ menuAction
]

{ #category : #accessing }
MarvinOtlLabelMorph >> menuAction: anObject [

	menuAction := anObject
]

{ #category : #'as yet unclassified' }
MarvinOtlLabelMorph >> minWidth [

	^ (StringMorph contents: name) width +20.
]

{ #category : #'as yet unclassified' }
MarvinOtlLabelMorph >> mouseDown: evt [

	evt redButtonPressed
		ifTrue:[ self owner toggleAction value: nil].

	evt yellowButtonPressed ifTrue: [
		self menuAction ifNotNilDo: [ :action | action value] ].
]

{ #category : #'as yet unclassified' }
MarvinOtlLabelMorph >> name [
 	
	^ name.
]

{ #category : #'as yet unclassified' }
MarvinOtlLabelMorph >> name: aString [ 

	name := aString.
	stringMorph contents: name.
	self extent: self width @ stringMorph height.
	self changed
]

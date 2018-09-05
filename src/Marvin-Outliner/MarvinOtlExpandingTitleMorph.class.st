Class {
	#name : #MarvinOtlExpandingTitleMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'name',
		'toggleAction',
		'menu',
		'labelMorph',
		'buttonMorph',
		'referenceButton'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlExpandingTitleMorph >> handlesMouseDown: evt [

	^ true.
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingTitleMorph >> initialize [

	super initialize.

	self color: (Color r: 0.835 g: 0.835 b: 0.771)..
	self borderWidth: 0.
	self layoutPolicy: ProportionalLayout new.
	self listDirection: #leftToRight.
	self cellInset: 5.
	self hResizing: #spaceFill.
	self vResizing: #shrinkWrap.

	labelMorph := MarvinOtlLabelMorph new.
	labelMorph hResizing: #spaceFill.
	self addMorph: labelMorph
		fullFrame: (
			LayoutFrame identity
				topOffset: 0; leftOffset: 12; rightOffset: 16; bottomOffset: 0). 

	buttonMorph := MarvinOtlDragButton new.

	self addMorph: buttonMorph
			fullFrame: (LayoutFrame identity
				rightFraction: 0; bottomFraction: 0;
				topOffset: 0; leftOffset: 0; rightOffset: 8; bottomOffset: 16). 

	referenceButton := MarvinOtlReferenceButton new.

	self addMorph: referenceButton copy
			fullFrame: (LayoutFrame identity
				leftFraction: 1; topFraction: 1;
				topOffset: -12; leftOffset: -12; rightOffset: -4; bottomOffset: -4). 

"	self height: (labelMorph height max: buttonMorph height)."

]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingTitleMorph >> menuAction [
	
	^ labelMorph menuAction
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingTitleMorph >> menuAction: anAction [ 
	
	labelMorph menuAction: anAction
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingTitleMorph >> minHeight [

	^ 16
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingTitleMorph >> minWidth [ 

	^ buttonMorph width * 3 + self cellInset + labelMorph minWidth 
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingTitleMorph >> name [
  ^name
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingTitleMorph >> name: aString [ 

	name := aString.
	labelMorph name: name.
	self changed
]

{ #category : #accessing }
MarvinOtlExpandingTitleMorph >> referenceButton [

	^ referenceButton
]

{ #category : #accessing }
MarvinOtlExpandingTitleMorph >> toggleAction [
	^toggleAction
]

{ #category : #accessing }
MarvinOtlExpandingTitleMorph >> toggleAction: anObject [

	toggleAction := anObject.
	buttonMorph toggleAction: anObject.
]

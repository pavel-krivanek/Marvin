Class {
	#name : #MarvinOtlSlotTitle,
	#superclass : #MarvinOtlComponentTitle,
	#instVars : [
		'dragButton',
		'referenceButton',
		'label'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlSlotTitle >> handlesMouseDown: evt [

	^ true.
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotTitle >> initialize [

	super initialize.
		
	super initialize.

	self color: (Color r: 0.835 g: 0.835 b: 0.771)..
	self borderWidth: 0.
	self layoutPolicy: ProportionalLayout new.
	self listDirection: #leftToRight.
	self cellInset: 5.
	self hResizing: #spaceFill.
	self vResizing: #none..

	label := 'slot description' asMorph.
	label height: 16.

	self addMorph: label
			fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 1@1) 
				offsets: (16@0 corner: -16@0)).

"	labelMorph := MarvinOtlLabelMorph new.
	labelMorph hResizing: #spaceFill.
	self addMorph: labelMorph
		fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 1@1) 
				offsets: (12@0 corner: -16@0))."

	dragButton := MarvinOtlDragButton new.

	self addMorph: dragButton
			fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 0@1) 
				offsets: (0@0 corner: 8@0)).

	referenceButton := MarvinOtlReferenceButton new.

	self addMorph: referenceButton copy
			fullFrame: (
			LayoutFrame 
				fractions: (1@1 corner: 1@1) 
				offsets: ((-12)@(-12) corner: (-4)@(-4))).

	self height: (label height max: dragButton height).

]

{ #category : #'as yet unclassified' }
MarvinOtlSlotTitle >> mouseDown: evt [

	evt redButtonPressed
		ifTrue:[ self outlinerComponent toggle: nil].

	evt yellowButtonPressed ifTrue: [
		self menuAction ifNotNilDo: [ :action | action value] ].
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotTitle >> optimalWidth [

	^ label contents asMorph width + 32
]

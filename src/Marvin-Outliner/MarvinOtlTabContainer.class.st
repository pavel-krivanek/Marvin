Class {
	#name : #MarvinOtlTabContainer,
	#superclass : #PasteUpMorph,
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlTabContainer >> initialize [

	super initialize.

	self color: Color transparent.
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self cellPositioning: #leftCenter.
	self reverseTableCells: true.
	self layoutInset: 5.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

]

{ #category : #'as yet unclassified' }
MarvinOtlTabContainer >> optimalWidth [

	^ (self submorphs collect: [ :m | m width]) max
]

{ #category : #'as yet unclassified' }
MarvinOtlTabContainer >> wantsDroppedMorph: aMorph event: evt [

	^ self isKindOf: #MarvinOtlSlot.
]

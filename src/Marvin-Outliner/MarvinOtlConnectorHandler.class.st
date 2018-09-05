Class {
	#name : #MarvinOtlConnectorHandler,
	#superclass : #BorderedMorph,
	#instVars : [
		'holder'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #accessing }
MarvinOtlConnectorHandler >> holder [
	"Answer the value of holder"

	^ holder
]

{ #category : #accessing }
MarvinOtlConnectorHandler >> holder: anObject [
	"Set the value of holder"

	holder := anObject
]

{ #category : #'as yet unclassified' }
MarvinOtlConnectorHandler >> initialize [

	super initialize.

	self extent: 8@8.
	self borderColor: #raised.
	self color:  (Color r: 0.935 g: 0.935 b: 0.871).

	self openInWorld..
]

{ #category : #'as yet unclassified' }
MarvinOtlConnectorHandler >> wantsToBeDroppedInto: aMorph [

	((aMorph isKindOf: MarvinOutliner) or:[aMorph isKindOf: MarvinOtlSlot])
		ifTrue: [ self holder: aMorph ]
		ifFalse:  [ self holder: nil ].
	
	^true.

]

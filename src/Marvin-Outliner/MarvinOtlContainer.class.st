Class {
	#name : #MarvinOtlContainer,
	#superclass : #Morph,
	#instVars : [
		'outlinerComponent'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlContainer >> initialize [

	super initialize.

	self color: Color red.
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self cellPositioning: #leftCenter.
	self reverseTableCells: true.
	self layoutInset: 5.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

]

{ #category : #'as yet unclassified' }
MarvinOtlContainer >> optimalWidth [

	| elements |

	elements := self submorphs.
	elements ifEmpty: [ ^ 0 ].

	^ (elements collect: [ :m | m width]) max
]

{ #category : #accessing }
MarvinOtlContainer >> outlinerComponent [
	^outlinerComponent
]

{ #category : #accessing }
MarvinOtlContainer >> outlinerComponent: anObject [
	outlinerComponent := anObject
]

{ #category : #'as yet unclassified' }
MarvinOtlContainer >> wantsDroppedMorph: aMorph event: evt [

	^ self isKindOf: #MarvinOtlSlot.
]

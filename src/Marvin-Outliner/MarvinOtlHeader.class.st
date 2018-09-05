Class {
	#name : #MarvinOtlHeader,
	#superclass : #BorderedMorph,
	#instVars : [
		'labelMorph'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlHeader >> adjustWidth: aNumber [

	self width: aNumber
]

{ #category : #'as yet unclassified' }
MarvinOtlHeader >> handlesMouseDown: evt [

	^ false.
]

{ #category : #'as yet unclassified' }
MarvinOtlHeader >> initialize [

	| evaluatorButton closeButton |

	super initialize.

	self color: (Color transparent)..
	self borderWidth: 0.
	self layoutPolicy: RowLayout new.
	self listDirection: #leftToRight.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

	self addMorph: ('Prototype adfasd fasd fas dfa sdfas dfas df asdf' asMorph).

	evaluatorButton := MarvinOtlHeaderButton new.
	evaluatorButton text: 'e'.
	evaluatorButton action: [ owner evaluator toggle: nil. ].
	self addMorph: evaluatorButton.
	
	closeButton := MarvinOtlHeaderButton new.
	closeButton text: 'x'.
	closeButton action: [ owner delete ].
	self addMorph: closeButton.



"	labelMorph := StringMorph new.
	self addMorph: labelMorph
		fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 1@1) 
				offsets: (19@0 corner: -16@0)).
"
"	buttonMorph := MarvinOtlDragMorph new.

	self addMorph: buttonMorph
			fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 0@0) 
				offsets: (0@0 corner: 16@16)).

	self addMorph: buttonMorph copy
			fullFrame: (
			LayoutFrame 
				fractions: (1@1 corner: 1@1) 
				offsets: ((-16)@(-16) corner: 0@0)).

	self height: (labelMorph height max: buttonMorph height).
"
	self height: 8.
]

{ #category : #'as yet unclassified' }
MarvinOtlHeader >> minHeigh [

	^ 8
]

{ #category : #'as yet unclassified' }
MarvinOtlHeader >> minWidth [ 

	^ 50
]

{ #category : #accessing }
MarvinOtlHeader >> optimalWidth [

	^  50.
]

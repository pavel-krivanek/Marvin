Class {
	#name : #MarvinOtlExpandingMorphContainer,
	#superclass : #PasteUpMorph,
	#instVars : [
		'name',
		'state',
		'titleMorph',
		'tabContainer'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> addElement: aMorph [ 

	tabContainer ifNil:  [
		tabContainer := MarvinOtlTabContainer new.
		self addMorph: tabContainer].

	tabContainer addMorph: aMorph.
	
	self layoutChanged
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> addTitle [

	titleMorph := MarvinOtlExpandingTitleMorph  new
		toggleAction: self toggleAction.
	
	self addMorph: titleMorph.
	
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> adjustWidth [

	| own |

	own := self owner.

	own ifNil: [ ^ self ].
	(own isKindOf: PasteUpMorph) ifTrue: [ ^ self ].

	 own adjustWidth.
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> adjustWidth: aNumber [

	titleMorph width: aNumber.


]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> handlesMouseDown: evt [

	^ false
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> hideableSubmorphs [

	^ self submorphs select:  [ :m | m ~= titleMorph ]
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> initialize [

	super initialize.

	state := #collapsed.

	self addTitle.


	self color: Color red.
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self reverseTableCells: true.
	self cellPositioning: #leftCenter.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.



	self enableDrag: false.
	
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> menuAction [

	^ titleMorph menuAction
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> menuAction: anAction [ 

	titleMorph menuAction: anAction
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> minHeight [

	^ 16
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> mouseDown: evt [


]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> name [
  ^name
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> name: aString [ 
	name := aString.
	titleMorph ifNotNil: [:title | titleMorph name: name. ].
	self changed
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> optimalWidth [

	^ state = #collapsed 
		ifTrue: [ titleMorph minWidth ] 
		ifFalse: [ (self hideableSubmorphs collect: [ :m | m optimalWidth]) max] 


]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> state [
  ^state
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> titleMorph [

	^ titleMorph
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> toggle: aSymbol [ 
	"Some obsolete code in this method, it would require an optimalization!"
	
	aSymbol 
		ifNil: [ 
			state := state = #collapsed
				ifTrue: [ #expanded ]
				ifFalse: [ #collapsed ] ]
		ifNotNil: [ state := aSymbol.].


	state = #collapsed 
		ifTrue: 
			[ titleMorph hResizing: #rigid.
			self hideableSubmorphs do: [ :m | m hide].
			self layoutChanged.
			self adjustWidth: titleMorph minWidth.
			self adjustWidth ]
		ifFalse: 
			[ self submorphs do: [:sm | sm = titleMorph ifFalse: [sm show]].
			self layoutChanged.
			titleMorph hResizing: #rigid.
			titleMorph layoutChanged.
			self adjustWidth: self optimalWidth .
			self adjustWidth.].

]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> toggleAction [

	^ MessageSend receiver: self selector: #toggle:
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingMorphContainer >> wantsDroppedMorph: aMorph event: evt [

	^ false

]

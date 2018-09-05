Class {
	#name : #MarvinOtlSlotWithComponents,
	#superclass : #MarvinOtlHideableComponent,
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> addElement: aMorph [ 

	container addMorph: aMorph.

	self layoutChanged
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> addTitle [

	self title: (MarvinOtlExpandingTitleMorph  new
		toggleAction: self toggleAction).

	self addMorph: self title.
	
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> adjustWidth: aNumber [

	super adjustWidth: aNumber.
	self title width: aNumber.


]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> handlesMouseDown: evt [

	^ false
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> hideableSubmorphs [

	^ self submorphs select:  [ :m | m ~= self title ]
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> initialize [

	super initialize.

	self color: Color transparent.
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self reverseTableCells: true.
	self cellPositioning: #leftCenter.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

	self addTitle.

	state := #collapsed.

	self enableDrag: false.
	
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> menuAction [

	^ self title menuAction
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> menuAction: anAction [ 

	self title menuAction: anAction
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> minHeigh [

	^ 16
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> mouseDown: evt [


]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> name [
  ^name
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> name: aString [ 
	"name := aString.
	titleMorph ifNotNilDo: [:Name already used in this class ->title | titleMorph name: name. ].
	self changed"
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> optimalWidth [

	^ state = #collapsed 
		ifTrue: [ self title minWidth ] 
		ifFalse: [ (self hideableSubmorphs collect: [ :m | m optimalWidth]) max] 


]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> state [
  ^state
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> titleMorph [

	^ self title
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> toggle: aSymbol [ 
	"Some obsolete code in this method, it would require an optimalization!"
	
	aSymbol 
		ifNil: [ 
			state := state = #collapsed
				ifTrue: [ #expanded ]
				ifFalse: [ #collapsed ] ]
		ifNotNil: [ state := aSymbol.].


	state = #collapsed 
		ifTrue: 
			[ self title hResizing: #rigid.
			self hideableSubmorphs do: [ :m | m hide].
			self layoutChanged.
			self adjustWidth: self title minWidth.
			self adjustWidth ]
		ifFalse: 
			[ self submorphs do: [:sm | sm = self title ifFalse: [sm show]].
			self layoutChanged.
			self title hResizing: #rigid.
			self title layoutChanged.
			self adjustWidth: self optimalWidth .
			self adjustWidth.].
	
	
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> toggleAction [

	^ MessageSend receiver: self selector: #toggle:
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotWithComponents >> wantsDroppedMorph: aMorph event: evt [

	^ false

]

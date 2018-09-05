Class {
	#name : #MarvinOtlHideableComponent,
	#superclass : #MarvinOtlComponent,
	#instVars : [
		'titleMorph',
		'state',
		'container'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> addElement: aMorph [ 

	container addMorph: aMorph behind: self title.

	self layoutChanged
]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> adjustWidth: minimalWidth [

	| maxWidth |

	maxWidth := minimalWidth max: self optimalWidth.

	super adjustWidth: maxWidth.

	self title ifNotNil: [
		self title width: maxWidth. ]
	



]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> container [

	^ container
]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> handlesMouseDown: evt [

	^ false
]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> initialize [

	super initialize.

	"self color: Color transparent."
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self reverseTableCells: true.
	self cellPositioning: #leftCenter.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

	self enableDrag: false.
	
	self title: MarvinOtlComponentTitle new.

	container := MarvinOtlContainer new.
	self addMorph: container.

	self toggle:#collapsed.

	
]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> optimalWidth [

	| titleWidth |
	
	titleWidth := self title ifNil: [50] ifNotNil: [ self title optimalWidth ].

	^ state = #collapsed 
		ifTrue: [ titleWidth ] 
		ifFalse: [ container optimalWidth max: titleWidth ] 


]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> state [

	^ state
]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> title [

	^ titleMorph
]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> title: aTitleMorph [
self halt.
	titleMorph := aTitleMorph.

	aTitleMorph outlinerComponent: self.
	titleMorph hResizing: #rigid.
	
	self addMorph: aTitleMorph after: container.

	
]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> toggle: aSymbol [ 
	
	aSymbol 
		ifNil: [ 
			state := state = #collapsed
				ifTrue: [ #expanded ]
				ifFalse: [ #collapsed ] ]
		ifNotNil: [ state := aSymbol.].


	state = #collapsed 
		ifTrue: [ container hide. ]
		ifFalse: [ container show].

	self title ifNotNil: [ self title layoutChanged ].
	self layoutChanged.
	self adjustWidth: self optimalWidth .
	self adjustWidth
	
	
]

{ #category : #'as yet unclassified' }
MarvinOtlHideableComponent >> wantsDroppedMorph: aMorph event: evt [

	^ false

]

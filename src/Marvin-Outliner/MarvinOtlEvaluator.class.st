Class {
	#name : #MarvinOtlEvaluator,
	#superclass : #MarvinOtlExpandingMorphContainer,
	#instVars : [
		'slotModel',
		'editor'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> acceptDroppingMorph: dropped event: evt [

	self owner acceptDroppingMorph: dropped event: evt

]

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> addTitle [

	titleMorph := MarvinOtlExpandingTitleMorph  new
		toggleAction: self toggleAction.

	self addMorph: titleMorph.	
	
	
]

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> adjustWidth [

	| own |

	own := self owner.

	own ifNil: [ ^ self ].
	(own isKindOf: PasteUpMorph) ifTrue: [ ^ self ].

	 own adjustWidth

]

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> initialize [

	super initialize.

	self color:  (Color r: 0.935 g: 0.935 b: 0.871).
	state := #expanded

	
]

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> model: anObject [ 

	| resizingMorph |

	slotModel := anObject.

	editor := PluggableTextMorph
				on: (MarvinOtlSlotModel on: anObject)
					text: #getText
					accept: #setText:
					readSelection: nil
					menu: #codePaneMenu:shifted:.
	editor extent: 320 @ 120.
	editor color: (Color r: 0.995 g: 0.995 b: 0.941).

	resizingMorph := MarvinOtlResizingMorph new.
	resizingMorph position: (editor position x + editor width) 
				@ (editor position y + editor height).
	editor addMorph: resizingMorph.

	self addElement: editor.

	self name: anObject asString.
	self toggle: state.

	self menuAction: (MessageSend receiver: self selector: #yellowButtonMenu)
]

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> newNameMorph [

	| morph |

	morph := StringMorph new.
	morph vResizing: #none.
	morph hResizing: #spaceFill.

	morph contents: 'name'.

	morph minWidth: 200.


	^ morph

]

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> newValueMorph [

	| morph |

	morph := StringMorph new.
	morph vResizing: #shrinkWrap.
	morph hResizing: #rigid.
	morph minWidth: 50.

	morph contents: 'val '.

	^ morph

]

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> wantsDroppedMorph: aMorph event: evt [

	^ self owner wantsDroppedMorph: aMorph event: evt
]

{ #category : #'as yet unclassified' }
MarvinOtlEvaluator >> yellowButtonMenu [

	| menu reply |

	menu := CustomMenu fromArray:
		#(	('add slot'		addSlot)
			-
			('rename'		renameSlot)
			('remove'		removeSlot)
			).
	reply := menu startUp.

	reply ifNil: [ ^ self ].

	
	
]

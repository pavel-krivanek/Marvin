Class {
	#name : #MarvinOtlSlot,
	#superclass : #MarvinOtlExpandingMorphContainer,
	#instVars : [
		'slotModel',
		'editor'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlSlot >> acceptDroppingMorph: dropped event: evt [

	self owner acceptDroppingMorph: dropped event: evt

]

{ #category : #'as yet unclassified' }
MarvinOtlSlot >> initialize [

	super initialize.

	self color:  (Color r: 0.935 g: 0.935 b: 0.871).
	self color: Color red.
	
	self menuAction: (MessageSend receiver: self selector: #yellowButtonMenu)
]

{ #category : #'as yet unclassified' }
MarvinOtlSlot >> justDroppedInto: aMorph event: anEvent [

	(aMorph isWorldMorph )
		ifTrue: [
			| outliner |
			outliner := MarvinOutliner new.
			outliner addSlot: self.
			outliner position: anEvent position.
			outliner openInWorld.		
			super justDroppedInto: aMorph event: anEvent  ]
		ifFalse: [ 
			super justDroppedInto: aMorph event: anEvent ].
			

	
]

{ #category : #'as yet unclassified' }
MarvinOtlSlot >> model: anObject [ 

	| resizingMorph |

	slotModel := anObject.

	editor := PluggableTextMorph
				on: (MarvinOtlSlotModel on: anObject)
					text: #getText
					accept: #setText:
					readSelection: nil
					menu: #codePaneMenu:shifted:.
	editor extent: 320 @ 120.
	editor color: Color white.

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
MarvinOtlSlot >> newNameMorph [

	| morph |

	morph := StringMorph new.
	morph vResizing: #none.
	morph hResizing: #spaceFill.

	morph contents: 'name'.

	morph minWidth: 200.


	^ morph

]

{ #category : #'as yet unclassified' }
MarvinOtlSlot >> newValueMorph [

	| morph |

	morph := StringMorph new.
	morph vResizing: #none.
	morph hResizing: #shrinkWrap.
	morph minWidth: 50.

	morph contents: 'val '.

	^ morph

]

{ #category : #'as yet unclassified' }
MarvinOtlSlot >> wantsDroppedMorph: aMorph event: evt [

	^ self owner wantsDroppedMorph: aMorph event: evt
]

{ #category : #'as yet unclassified' }
MarvinOtlSlot >> yellowButtonMenu [

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

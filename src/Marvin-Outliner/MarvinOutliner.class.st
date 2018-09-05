"
| o oo ref  |

o := MarvinOutliner new.
o addSlot: (ref := MarvinOtlSlot new model: 1).
o addSlot: (MarvinOtlSlot new model: 2).
o addSlot: (MarvinOtlSlot new model: 3).
o openInWorld position: 100@100..

oo := MarvinOutliner new.
oo addSlot: (MarvinOtlSlot new model: 5).
oo addSlot: (MarvinOtlSlot new model: 6).
oo addSlot: (MarvinOtlSlot new model: 7).
oo openInWorld position: 300@200.

MarvinOtlConnector new from: ref  to: oo
(16 1 2 1 14 1 3 2 1 1 8 2 3 1 2 1 13 1 3 1 6 1 1 3 1 1 8 2 13 1 3 1 6 1 1 3 1 1 8 2 13 1 3 1 6 1 1 3 1 1 11 1 9 1 3 1 3 4 2 1 2 1 14 1 3 2 2 1 8 2 13 1 3 1 6 1 1 3 2 1 8 2 13 1 3 1 6 1 1 3 2 1 8 2 13 1 3 1 6 1 1 3 2 1 11 1 9 1 3 1 3 3 18 1 3 1 5 1 3 2 3 1 2 1)cblack;b,cblack;,b,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;,b,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,c122000000,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,c122000000,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,c122000000,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,c122000000,c000000122,c122000000,cblack;,cblack;b,cblack;,b,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,c122000000,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,c122000000,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,c122000000,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,c122000000,c000000122,c122000000,cblack;,cblack;b,cblack;,c000000122,cblack;,c000000122,cblack;,cblack;b,cblack;,c000000122,cblack;,cblack;b,cblack;
"
Class {
	#name : #MarvinOutliner,
	#superclass : #BorderedMorph,
	#instVars : [
		'slots',
		'header',
		'evaluator'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOutliner >> acceptDroppingMorph: dropped event: evt [
	
	(dropped isKindOf: MarvinOtlSlot) 
		ifTrue: [ self addSlot: dropped ].
	
	(dropped isKindOf: MarvinOtlConnectorHandler ) 
		ifTrue: [ dropped holder: self ].

]

{ #category : #'as yet unclassified' }
MarvinOutliner >> addComponent: anOutlinerComponent [

	self addMorph: anOutlinerComponent.
	anOutlinerComponent outliner: self.
	self adjustWidth.

	
]

{ #category : #'as yet unclassified' }
MarvinOutliner >> addComponent: anOutlinerComponent after: anComponent [

	self addMorph: anOutlinerComponent after: anComponent.
	anOutlinerComponent outliner: self.
	self adjustWidth.

	
]

{ #category : #'as yet unclassified' }
MarvinOutliner >> addComponent: anOutlinerComponent behind: anComponent [

	self addMorph: anOutlinerComponent behind: anComponent.
	anOutlinerComponent outliner: self.
	self adjustWidth.

	
]

{ #category : #'as yet unclassified' }
MarvinOutliner >> addSlot: aSlot [

	self addMorph: aSlot behind: evaluator.
	self adjustWidth.

	
]

{ #category : #'as yet unclassified' }
MarvinOutliner >> adjustWidth [

	| optimalWidth |
	
	optimalWidth := self optimalWidth . 

	submorphs do: [ :m | 
		m adjustWidth: optimalWidth ].
	
	
]

{ #category : #'as yet unclassified' }
MarvinOutliner >> evaluator [

	^ evaluator
]

{ #category : #'as yet unclassified' }
MarvinOutliner >> initialize [

	super initialize.

	self layoutPolicy: TableLayout new.
	self listDirection: #topToBottom.
	self hResizing: #shrinkWrap; vResizing: #shrinkWrap.
	self layoutInset: 4; cellInset: 2.
	self cellPositioning: #topLeft.
	self color:  (Color r: 0.935 g: 0.935 b: 0.871).
	self minCellSize: 100@10.

	self borderWidth: 2.
	self borderColor: #raised.

	self reverseTableCells: true.

	header := MarvinOtlHeader new.
	self addMorph: header.

	evaluator := (MarvinOtlEvaluator new model: 'Evaluator').
	self addMorph: evaluator.
	self adjustWidth.

	



]

{ #category : #'as yet unclassified' }
MarvinOutliner >> optimalWidth [

	^ (submorphs collect: [ :m | m optimalWidth ]) max.
]

{ #category : #'as yet unclassified' }
MarvinOutliner >> wantsDroppedMorph: aMorph event: evt [

	(aMorph isKindOf: MarvinOtlConnectorHandler ) 
		ifTrue: [ 
			aMorph holder: self.
			^ false ].


	^ (aMorph isKindOf: MarvinOtlSlot) or: [aMorph isKindOf: MarvinOtlConnectorHandler ] .

]

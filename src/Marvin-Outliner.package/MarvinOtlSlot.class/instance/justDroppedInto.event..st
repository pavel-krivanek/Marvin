as yet unclassified
justDroppedInto: aMorph event: anEvent

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
			

	
as yet unclassified
justDroppedInto: aMorph event: anEvent

	(aMorph isWorldMorph )
		ifTrue: [ 
			| newOutliner |
			newOutliner := MarvinOutliner new.
			newOutliner addSlot: self.
			newOutliner position: anEvent position.
			newOutliner openInWorld.		
			super justDroppedInto: aMorph event: anEvent  ]
		ifFalse: [ 
			super justDroppedInto: aMorph event: anEvent ].
			

	
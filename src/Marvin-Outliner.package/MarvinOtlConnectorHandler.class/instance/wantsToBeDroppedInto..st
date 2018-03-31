as yet unclassified
wantsToBeDroppedInto: aMorph

	((aMorph isKindOf: MarvinOutliner) or:[aMorph isKindOf: MarvinOtlSlot])
		ifTrue: [ self holder: aMorph ]
		ifFalse:  [ self holder: nil ].
	
	^true.

as yet unclassified
numArguments

	^ (self slots select: [ :slot | slot type = #argumentSlot ]) size.

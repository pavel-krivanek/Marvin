as yet unclassified
onMorph: aMorph newStateSelector: aSymbol

	^ (self new) 	toggleAction: (MessageSend receiver: aMorph selector: aSymbol).
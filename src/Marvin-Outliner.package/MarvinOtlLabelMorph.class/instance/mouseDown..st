as yet unclassified
mouseDown: evt

	evt redButtonPressed
		ifTrue:[ self owner toggleAction value: nil].

	evt yellowButtonPressed ifTrue: [
		self menuAction ifNotNilDo: [ :action | action value] ].
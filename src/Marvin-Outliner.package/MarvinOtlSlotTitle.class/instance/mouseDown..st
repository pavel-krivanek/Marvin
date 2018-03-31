as yet unclassified
mouseDown: evt

	evt redButtonPressed
		ifTrue:[ self outlinerComponent toggle: nil].

	evt yellowButtonPressed ifTrue: [
		self menuAction ifNotNilDo: [ :action | action value] ].
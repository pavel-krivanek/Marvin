as yet unclassified
mouseDown: evt

	(evt redButtonPressed and: [self containsPoint: evt cursorPoint])
		ifTrue:[
			evt hand grabMorph: self owner owner ].
as yet unclassified
mouseDown: evt

	(evt redButtonPressed and: [self containsPoint: evt cursorPoint])
		ifTrue:[ self action value ]
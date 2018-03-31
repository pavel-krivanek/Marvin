as yet unclassified
mouseDown: evt

	(evt redButtonPressed and: [self containsPoint: evt cursorPoint])
		ifTrue:[
			state=#collapsed 
				ifTrue: [self expand] 
				ifFalse: [self collapse] ].
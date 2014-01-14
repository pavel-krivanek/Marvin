generating
pushObject: aCollection

	| object context |
	
	object := aCollection first value.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: object).
	
	^ context.
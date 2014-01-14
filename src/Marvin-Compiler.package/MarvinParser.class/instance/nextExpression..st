generating
nextExpression: aCollection

	| context |
	
	context := aCollection first value.

	context addInstruction: (context generator instrPop).

	context + aCollection third value.

	^ context
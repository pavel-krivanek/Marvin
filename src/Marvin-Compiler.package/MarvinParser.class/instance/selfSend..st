generating
selfSend: aCollection

	| identifier context |
	
	identifier := aCollection first value.
	
	context := MarvinContext new.
	context addInstruction: (context generator instrPushSelf). 
	context addInstruction: (context generator instrSelfSend: identifier numArgs: 0).

	
	
	^ context.
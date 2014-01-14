generating
pushSelf: aCollection

	| context |
	
	context := MarvinContext new.
	context addInstruction: (context generator instrPushSelf).
	
	^ context.
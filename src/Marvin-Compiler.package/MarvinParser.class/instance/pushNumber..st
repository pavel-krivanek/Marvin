generating
pushNumber: aCollection

	| number context |
	
	number := aCollection first value asNumber.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: number)).
	
	^ context.
generating-literals
pushString: aCollection

	| string context |
	
	string := self stringFromLiteral: aCollection first value.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: string)).
	
	^ context.
generating-literals
pushCharacter: aCollection

	| char context |
	
	char := aCollection first value second asCharacter.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: char)).
	
	^ context.
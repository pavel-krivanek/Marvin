generating-literals
pushArray: aCollection

	| array context |
	
	array := Array withAll: aCollection second value.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: array)).
	
	^ context.
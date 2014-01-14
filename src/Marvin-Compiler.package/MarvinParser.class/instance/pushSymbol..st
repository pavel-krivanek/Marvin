generating-literals
pushSymbol: aCollection

	| symbol context |
	
	symbol := self symbolFromLiteral: aCollection first value asSymbol.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: symbol)).
	
	^ context.
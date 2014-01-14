generating
returnLongExpressionCode: aCollection 
	
	| context |

	context := aCollection first value.
	context addInstruction: (context generator instrPop ).
	context + (aCollection at: 4) value.
	context addInstruction: (context generator instrReturnTop ).

	^ context regenerate
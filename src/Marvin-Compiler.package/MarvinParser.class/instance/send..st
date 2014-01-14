generating
send: aCollection

	| identifier context |
	
	context := aCollection first value.

	identifier := aCollection second value.
	
	context addInstruction: (context generator instrSend: identifier  numArgs: 0 ).

	^ context.
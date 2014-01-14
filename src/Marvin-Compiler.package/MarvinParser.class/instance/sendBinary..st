generating
sendBinary: aCollection

	| operator context |
	
	operator := aCollection second value.
	
	context := aCollection first value. 	
	
	context + aCollection third value.
	context addInstruction: (context generator instrSend: operator  numArgs: 1).
	
	^ context.
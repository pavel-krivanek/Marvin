generating
resendBinary: aCollection

	| operator argument context |
	
	operator := aCollection second value.
	argument := aCollection third value.
	
	context := argument.
	context addInstruction: (context generator instrResend: operator numArgs: 1).
	
	^ context.
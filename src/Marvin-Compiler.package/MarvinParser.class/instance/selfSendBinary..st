generating
selfSendBinary: aCollection

	| operator argument context |

	operator := aCollection first value.
	argument := aCollection second value.

	context := MarvinContext new.
	context addInstruction: (context generator instrPushSelf).
	context + argument.
	context addInstruction: (context generator instrSend: operator numArgs: 1).
	
	^ context.
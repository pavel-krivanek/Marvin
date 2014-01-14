generating
resend: aCollection 
	| identifier context |
	identifier := aCollection second value.
	context := MarvinContext new.
	context addInstruction: context generator instrPushSelf.
	context addInstruction: (context generator instrResend: identifier numArgs: 0).
	^context
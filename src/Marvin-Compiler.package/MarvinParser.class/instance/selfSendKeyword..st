generating
selfSendKeyword: aCollection

	| selector arguments context |

	selector := self getKeywordSelector: aCollection offset: 0.
	arguments := self getKeywordArguments: aCollection offset: 0.

	context := MarvinContext new.

	context addInstruction: (context generator instrPushSelf). 

	arguments do: [:arg |
		context + arg.
	].

	context addInstruction: (context generator instrSelfSend: selector numArgs: arguments size).

	^ context
generating
resendKeyword: aCollection

	| selector arguments context |

	selector := self getKeywordSelector: aCollection offset: 0.
	arguments := self getKeywordArguments: aCollection offset: 0.
	
	context := MarvinContext new.

	arguments do: [:arg |
		context + arg.
	].

	context addInstruction: (context generator instrResend: selector numArgs: arguments size).

	^ context
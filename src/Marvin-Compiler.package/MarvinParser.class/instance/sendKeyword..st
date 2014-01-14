generating
sendKeyword: aCollection

	| selector arguments context |

	selector := self getKeywordSelector: aCollection offset: 1.
	arguments := self getKeywordArguments: aCollection offset: 1.

	context := aCollection first value.

	arguments do: [:arg |
		context + arg.
	].

	context addInstruction: (context generator instrSend: selector  numArgs: arguments size) .

	^ context
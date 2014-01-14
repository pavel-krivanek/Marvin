generating
returnSingleExpresion: aCollection

	| context |

	context := aCollection second value.
	context addInstruction: (context generator instrReturnTop ).

	^ context regenerate
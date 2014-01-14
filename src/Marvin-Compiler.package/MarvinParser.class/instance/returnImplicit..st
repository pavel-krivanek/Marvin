generating
returnImplicit: aCollection

	| context |

	context := aCollection first value.
	context addInstruction: (context generator instrReturnImplicit  ).

	^ context regenerate
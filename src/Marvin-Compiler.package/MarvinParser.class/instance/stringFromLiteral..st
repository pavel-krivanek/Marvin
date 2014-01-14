generating-literals
stringFromLiteral: aString

	^ (aString withoutQuoting) copyReplaceAll: '''''' with: ''''.
		
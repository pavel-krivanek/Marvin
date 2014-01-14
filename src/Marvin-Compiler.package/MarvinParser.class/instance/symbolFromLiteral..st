generating-literals
symbolFromLiteral: aString

	^ (self stringFromLiteral: aString allButFirst) asSymbol
		
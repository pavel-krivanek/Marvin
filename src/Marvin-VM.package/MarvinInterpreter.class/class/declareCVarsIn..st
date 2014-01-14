as yet unclassified
declareCVarsIn: aCCodeGenerator

	super declareCVarsIn: aCCodeGenerator.
	aCCodeGenerator
		var: #sack
		declareC: 'int sack[', (SackSize + 1) printString, ']'.
generating-literals
arraySymbol: aCollection

	^ aCollection first value allButFirst withoutQuoting asSymbol.
	
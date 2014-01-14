printing
printOn: aStream

	aStream 
		nextPutAll: 'Object ('.

	aStream 
		tab; nextPutAll: 'Literals:'; cr..
	self literals do: [:literal | aStream tab; tab. literal printOn: aStream. aStream cr. ].
	
	aStream 
		tab; nextPutAll: 'Instructions:'; cr.
	self instructions do: [:instruction | aStream tab; tab. instruction printOn: aStream. aStream cr.].
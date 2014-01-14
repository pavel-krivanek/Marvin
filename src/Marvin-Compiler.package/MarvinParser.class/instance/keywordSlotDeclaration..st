generating
keywordSlotDeclaration: aCollection

	| previous |
	previous := aCollection third value.

	previous ifEmpty: [ 
		^ { aCollection first value. { aCollection second value }}
	].

	^ { 
		aCollection first value, previous first.
		{aCollection second value}, previous second.
	} 
		
		


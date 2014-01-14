generating
keywordNextParameters: aCollection

	| previous |

	previous := aCollection third value.
	previous ifEmpty: [
		previous := { String new. OrderedCollection new } ].

	^ { 
		aCollection first value, previous first.
		{aCollection second value}, previous second.
	} 
		


generating
blockWithoutSlots: aCollection

	| block |
	
	block := MarvinBlockLiteral new.
	
	block context: aCollection second value.
		
	^ block.
	


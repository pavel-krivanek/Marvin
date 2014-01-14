generating
block: aCollection

	| block |
	
	block := MarvinBlockLiteral new.
	
	aCollection size = 3
		ifTrue: [
			block slots: aCollection second value.
			 ].
	
	aCollection size = 4
		ifTrue: [ 
			block slots: aCollection second value.
			block context: aCollection third value.
		 ].

	^ block.
	


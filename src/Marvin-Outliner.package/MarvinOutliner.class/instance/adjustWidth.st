as yet unclassified
adjustWidth

	| optimalWidth |
	
	optimalWidth := self optimalWidth . 

	submorphs do: [ :m | 
		m adjustWidth: optimalWidth ].
	
	
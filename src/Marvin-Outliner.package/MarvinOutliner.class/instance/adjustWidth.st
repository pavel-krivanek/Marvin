as yet unclassified
adjustWidth

	| optimalWidth |
	
	optimalWidth := self optimalWidth + 22. 

	submorphs do: [ :m | 
		m adjustWidth: optimalWidth ].
	
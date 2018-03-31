as yet unclassified
toggle: aSymbol 
	
	aSymbol 
		ifNil: [ 
			state := state = #collapsed
				ifTrue: [ #expanded ]
				ifFalse: [ #collapsed ] ]
		ifNotNil: [ state := aSymbol.].


	state = #collapsed 
		ifTrue: [ container hide. ]
		ifFalse: [ container show].

	self title ifNotNil: [ self title layoutChanged ].
	self layoutChanged.
	self adjustWidth: self optimalWidth .
	self adjustWidth
	
	
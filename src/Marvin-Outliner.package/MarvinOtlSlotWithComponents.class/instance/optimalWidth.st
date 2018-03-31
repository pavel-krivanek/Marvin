as yet unclassified
optimalWidth

	^ state = #collapsed 
		ifTrue: [ self title minWidth ] 
		ifFalse: [ (self hideableSubmorphs collect: [ :m | m optimalWidth]) max] 


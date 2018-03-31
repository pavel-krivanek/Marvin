as yet unclassified
optimalWidth

	^ state = #collapsed 
		ifTrue: [ titleMorph minWidth ] 
		ifFalse: [ (self hideableSubmorphs collect: [ :m | m optimalWidth]) max] 


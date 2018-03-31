as yet unclassified
optimalWidth

	| titleWidth |
	
	titleWidth := self title ifNil: [50] ifNotNil: [ self title optimalWidth ].

	^ state = #collapsed 
		ifTrue: [ titleWidth ] 
		ifFalse: [ container optimalWidth max: titleWidth ] 


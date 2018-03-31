as yet unclassified
drawOn: aCanvas 

	| offset |
	
	offset := self width - expandedForm width // 2.

	state = #expanded 
		ifTrue: [aCanvas paintImage: expandedForm at: self position + offset]
		ifFalse: [aCanvas paintImage: collapsedForm at: self position + offset]
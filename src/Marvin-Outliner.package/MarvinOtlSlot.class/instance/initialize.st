as yet unclassified
initialize

	super initialize.

	self color:  (Color r: 0.935 g: 0.935 b: 0.871).
	self color: Color red.
	
	self menuAction: (MessageSend receiver: self selector: #yellowButtonMenu)
as yet unclassified
mouseUp: evt
	
	self owner resizeAction ifNotNilDo: [ :action |
		action value ].
	
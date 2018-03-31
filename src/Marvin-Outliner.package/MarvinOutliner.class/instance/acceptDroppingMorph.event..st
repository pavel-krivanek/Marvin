as yet unclassified
acceptDroppingMorph: dropped event: evt
	
	(dropped isKindOf: MarvinOtlSlot) 
		ifTrue: [ self addSlot: dropped ].
	
	(dropped isKindOf: MarvinOtlConnectorHandler ) 
		ifTrue: [ dropped holder: self ].

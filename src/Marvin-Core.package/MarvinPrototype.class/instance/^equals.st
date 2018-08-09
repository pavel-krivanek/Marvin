support
= anObject 

	| result |
	
	result := self PerformMessage: (Message selector: #= argument: anObject) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self == anObject  ]
		ifFalse: [ result ]

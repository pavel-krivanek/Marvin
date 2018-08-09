support
printString

	| result |
	
	result := self PerformMessage: (Message selector: #printString) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ 'aMarvinPrototype' ]
		ifFalse: [ result ]

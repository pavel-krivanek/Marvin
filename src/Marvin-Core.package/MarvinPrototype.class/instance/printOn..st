support
printOn: aStream

	| result |
	
	result := self PerformMessage: (Message selector: #printOn: argument: aStream) inContextOf: self.
	
	result == MarvinPrototype DNU 
		ifTrue: [ aStream << 'aMarvinPrototype' ]
		ifFalse: [ result ]

support
size

	| result |
	
	result := self PerformMessage: (Message selector: #size) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self PrimitiveSize ]
		ifFalse: [ result ]

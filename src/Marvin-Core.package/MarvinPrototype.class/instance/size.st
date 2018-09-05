support
size

	| result |
	
	result := self _PerformMessage: (Message selector: #size) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self _PrimitiveSize ]
		ifFalse: [ result ]

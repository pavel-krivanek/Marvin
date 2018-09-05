reflective operations
doesNotUnderstand: aMessage 

	| result |
	
	result := self _PerformMessage: aMessage inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self slotNotFound: aMessage. ]
		ifFalse: [ result ]

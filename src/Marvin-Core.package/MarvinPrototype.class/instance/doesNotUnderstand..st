reflective operations
doesNotUnderstand: aMessage 

	| result |
	
	result := self performMessage: aMessage inContextOf: self.
	
	^ result == #DNU 
		ifTrue: [ self slotNotFound: aMessage. ]
		ifFalse: [ result ]

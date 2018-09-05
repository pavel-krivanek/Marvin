support
isString

	| result |
	
	result := self _PerformMessage: (Message selector: #isString) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ false]
		ifFalse: [ result ]


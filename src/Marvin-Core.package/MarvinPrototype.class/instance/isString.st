support
isString

	| result |
	
	result := self PerformMessage: (Message selector: #isString) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ false]
		ifFalse: [ result ]


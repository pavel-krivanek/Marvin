support
class

	| result |
	
	result := self PerformMessage: (Message selector: #class) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ super class ]
		ifFalse: [ result ]

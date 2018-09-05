support
class

	| result |
	
	result := self _PerformMessage: (Message selector: #class) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ super class ]
		ifFalse: [ result ]

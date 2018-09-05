support
inspect
	"Create and schedule an Inspector in which the user can examine the receiver's variables."

	| result |
	
	result := self _PerformMessage: (Message selector: #inspect) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ Smalltalk tools inspector inspect: self ]
		ifFalse: [ result ]
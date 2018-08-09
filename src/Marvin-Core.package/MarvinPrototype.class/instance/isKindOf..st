support
isKindOf: aClass

	| result |
	
	result := self PerformMessage: (Message selector: #isKindOf argument: aClass) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self class == aClass
			ifTrue: [^true]
			ifFalse: [^self class inheritsFrom: aClass] ]
		ifFalse: [ result ]


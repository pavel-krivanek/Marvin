support
hash

	| result |
	
	result := self PerformMessage: (Message selector: #hash) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ self identityHash ]
		ifFalse: [ result ]

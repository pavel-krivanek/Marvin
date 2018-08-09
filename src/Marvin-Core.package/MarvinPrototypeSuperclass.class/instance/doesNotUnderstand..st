reflective operations
doesNotUnderstand: aMessage 

	| result owningObject |
	owningObject := thisContext sender method propertyAt: #owningObject.
	result := owningObject PerformMessageSupersend: aMessage inContextOf: self.
	
	^ result == MarvinPrototype DNU
		ifTrue: [ self slotNotFound: aMessage. ]
		ifFalse: [ result ]

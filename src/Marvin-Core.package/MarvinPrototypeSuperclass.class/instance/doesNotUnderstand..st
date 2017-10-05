reflective operations
doesNotUnderstand: aMessage 

	| result owningObject |
	owningObject := thisContext sender method propertyAt: #owningObject.
	result := owningObject performMessageSupersend: aMessage inContextOf: self.
	
	^ result == #DNU 
		ifTrue: [ self slotNotFound: aMessage. ]
		ifFalse: [ result ]

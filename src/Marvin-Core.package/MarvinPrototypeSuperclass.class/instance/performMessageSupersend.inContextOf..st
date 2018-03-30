reflective operations
performMessageSupersend: aMessage inContextOf: anObject

	| messageSelector index  |
	
	messageSelector := aMessage selector.

	index := 1.

	[ (self at: index) == nil ]
			whileFalse: [
				| parent resultFromParent |
				parent := self at: index+2.
				resultFromParent := parent performMessage: aMessage inContextOf: anObject.
				resultFromParent ~= #DNU
					ifTrue: [ ^ resultFromParent ].
				index := index + 3 ].
	
	^ #DNU



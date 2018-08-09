reflective operations
performMessageSupersend: aMessage inContextOf: anObject

	| messageSelector index  |
	
	messageSelector := aMessage selector.

	index := self primitiveSize.

	[ (self at: index) == nil ]
			whileFalse: [
				| parent resultFromParent |
				parent := self at: index-2.
				resultFromParent := parent performMessage: aMessage inContextOf: anObject.
				resultFromParent ~= MarvinPrototype DNU
					ifTrue: [ ^ resultFromParent ].
				index := index - 3 ].
	
	^ MarvinPrototype DNU



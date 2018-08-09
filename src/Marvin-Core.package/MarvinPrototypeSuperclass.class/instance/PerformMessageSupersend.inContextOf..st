reflective operations
PerformMessageSupersend: aMessage inContextOf: anObject

	| messageSelector index  |
	
	messageSelector := aMessage selector.

	index := self PrimitiveSize.

	[ (self PrimitiveAt: index) == nil ]
			whileFalse: [
				| parent resultFromParent |
				parent := self PrimitiveAt: index-2.
				resultFromParent := parent PerformMessage: aMessage inContextOf: anObject.
				resultFromParent ~= MarvinPrototype DNU
					ifTrue: [ ^ resultFromParent ].
				index := index - 3 ].
	
	^ MarvinPrototype DNU



reflective operations
_PerformMessageSupersend: aMessage inContextOf: anObject

	| messageSelector index  |
	
	messageSelector := aMessage selector.

	index := self _PrimitiveSize.

	[ (self _PrimitiveAt: index) == nil ]
			whileFalse: [
				| parent resultFromParent |
				parent := self _PrimitiveAt: index-2.
				resultFromParent := parent _PerformMessage: aMessage inContextOf: anObject.
				resultFromParent ~= MarvinPrototype DNU
					ifTrue: [ ^ resultFromParent ].
				index := index - 3 ].
	
	^ MarvinPrototype DNU



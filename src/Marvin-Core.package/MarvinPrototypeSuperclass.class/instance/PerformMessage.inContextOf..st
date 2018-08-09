reflective operations
PerformMessage: aMessage inContextOf: anObject

	| messageSelector index currentSlot |
	
	messageSelector := aMessage selector.

	index := self PrimitiveSize.
	
	" process parent slots as messgaes "
	[ (currentSlot := self PrimitiveAt: index) == nil ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) 
				ifTrue: [
					" push value of slot "
					^ self PrimitiveAt: index - 2].
			" write message "
			currentSlot := self PrimitiveAt: index-1.
			(currentSlot = messageSelector) 
				ifTrue: [ 
					" write value to slot "
					self PrimitiveAt: index - 2 put: aMessage argument.
					^ anObject ] .
			index := index - 3 ].

	index := index - 1.
	
	" process method slots "

	[ (currentSlot := self PrimitiveAt: index) = nil ]
		whileFalse: [ 
			(currentSlot = messageSelector) 
				ifTrue: [
					^ (self PrimitiveAt: index - 1) valueWithReceiver: anObject arguments: aMessage arguments ].
			index := index - 2 ].

	index := index - 1.

	[ (currentSlot := self PrimitiveAt: index) = nil ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) 
				ifTrue: [
					" push value of slot "
					^ self PrimitiveAt: index - 2].
			" write message "
			currentSlot := self PrimitiveAt: index-1.
			(currentSlot = messageSelector) 
				ifTrue: [ 
					" write value to slot "
					self PrimitiveAt: index - 2 put: aMessage argument.
					^ anObject ] .
			index := index - 3 ].
		
	index := self PrimitiveSize.

	[ (self PrimitiveAt: index) = nil ]
			whileFalse: [
				| parent resultFromParent |
				parent := self PrimitiveAt: index-2.
				resultFromParent := parent PerformMessage: aMessage inContextOf: anObject.
				resultFromParent ~= MarvinPrototype DNU
					ifTrue: [ ^ resultFromParent ].
				index := index - 3 ].
	
	^ MarvinPrototype DNU



reflective operations
performMessage: aMessage inContextOf: anObject

	| messageSelector index currentSlot |
	
	messageSelector := aMessage selector.

	index := 1.
	
	" process parent slots as messgaes "
	[ (currentSlot := self at: index) == nil ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) 
				ifTrue: [
					" push value of slot "
					^ self at: index + 2].
			" write message "
			currentSlot := self at: index+1.
			(currentSlot = messageSelector) 
				ifTrue: [ 
					" write value to slot "
					self at: index + 2 put: aMessage argument.
					^ anObject ] .
			index := index + 3 ].

	index := index + 1.
	
	" process method slots "

	[ (currentSlot := self at: index) = nil ]
		whileFalse: [ 
			(currentSlot = messageSelector) 
				ifTrue: [
					^ (self at: index + 1) valueWithReceiver: anObject arguments: aMessage arguments ].
			index := index + 2 ].

	index := index + 1.

	[ (currentSlot := self at: index) = nil ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) 
				ifTrue: [
					" push value of slot "
					^ self at: index + 2].
			" write message "
			currentSlot := self at: index+1.
			(currentSlot = messageSelector) 
				ifTrue: [ 
					" write value to slot "
					self at: index + 2 put: aMessage argument.
					^ anObject ] .
			index := index + 3 ].
		
	index := 1.

	[ (self at: index) = nil ]
			whileFalse: [
				| parent resultFromParent |
				parent := self at: index+2.
				resultFromParent := parent performMessage: aMessage inContextOf: anObject.
				resultFromParent ~= MarvinPrototype DNU
					ifTrue: [ ^ resultFromParent ].
				index := index + 3 ].
	
	^ MarvinPrototype DNU



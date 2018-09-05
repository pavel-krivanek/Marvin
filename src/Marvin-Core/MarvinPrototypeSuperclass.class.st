Class {
	#name : #MarvinPrototypeSuperclass,
	#superclass : #ProtoObject,
	#type : #variable,
	#category : 'Marvin-Core'
}

{ #category : #'reflective operations' }
MarvinPrototypeSuperclass >> _PerformMessage: aMessage inContextOf: anObject [

	| messageSelector index currentSlot |
	
	messageSelector := aMessage selector.

	index := self _PrimitiveSize.
	
	" process parent slots as messgaes "
	[ (currentSlot := self _PrimitiveAt: index) == nil ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) 
				ifTrue: [
					" push value of slot "
					^ self _PrimitiveAt: index - 2].
			" write message "
			currentSlot := self _PrimitiveAt: index-1.
			(currentSlot = messageSelector) 
				ifTrue: [ 
					" write value to slot "
					self _PrimitiveAt: index - 2 put: aMessage argument.
					^ anObject ] .
			index := index - 3 ].

	index := index - 1.
	
	" process method slots "

	[ (currentSlot := self _PrimitiveAt: index) = nil ]
		whileFalse: [ 
			(currentSlot = messageSelector) 
				ifTrue: [
					^ (self _PrimitiveAt: index - 1) valueWithReceiver: anObject arguments: aMessage arguments ].
			index := index - 2 ].

	index := index - 1.

	[ (currentSlot := self _PrimitiveAt: index) = nil ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) 
				ifTrue: [
					" push value of slot "
					^ self _PrimitiveAt: index - 2].
			" write message "
			currentSlot := self _PrimitiveAt: index-1.
			(currentSlot = messageSelector) 
				ifTrue: [ 
					" write value to slot "
					self _PrimitiveAt: index - 2 put: aMessage argument.
					^ anObject ] .
			index := index - 3 ].
		
	index := self _PrimitiveSize.

	[ (self _PrimitiveAt: index) = nil ]
			whileFalse: [
				| parent resultFromParent |
				parent := self _PrimitiveAt: index-2.
				resultFromParent := parent _PerformMessage: aMessage inContextOf: anObject.
				resultFromParent ~= MarvinPrototype DNU
					ifTrue: [ ^ resultFromParent ].
				index := index - 3 ].
	
	^ MarvinPrototype DNU



]

{ #category : #'reflective operations' }
MarvinPrototypeSuperclass >> _PerformMessageSupersend: aMessage inContextOf: anObject [

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



]

{ #category : #'reflective operations' }
MarvinPrototypeSuperclass >> _PrimitiveAt: anIndex [

	<primitive: 173 error: ec>
	self primitiveFailed
]

{ #category : #'reflective operations' }
MarvinPrototypeSuperclass >> _PrimitiveAt: anIndex put: anObject [

	<primitive: 174 error: ec>
	self primitiveFailed
]

{ #category : #'reflective operations' }
MarvinPrototypeSuperclass >> _PrimitiveSize [

	<primitive: 62>
	^ 0
]

{ #category : #'reflective operations' }
MarvinPrototypeSuperclass >> doesNotUnderstand: aMessage [ 

	| result owningObject |
	owningObject := thisContext sender method propertyAt: #owningObject.
	result := owningObject _PerformMessageSupersend: aMessage inContextOf: self.
	
	^ result == MarvinPrototype DNU
		ifTrue: [ self slotNotFound: aMessage. ]
		ifFalse: [ result ]

]

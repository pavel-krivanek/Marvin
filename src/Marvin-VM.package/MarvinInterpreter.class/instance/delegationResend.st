as yet unclassified
delegationResend

	| result index currentSlot argument activeMethod methodOwner |

	self inline: true.
	
	sackPosition := 0.

	activeMethod := self fetchPointer: MethodIndex ofObject: (self stackValue: 1) .
	methodOwner := self literal: (self literalCountOf: activeMethod) - 1 ofMethod: activeMethod.
	
	result := self findSlot: messageSelector inParentsOf: methodOwner.
	
	(result = self nilObject)
		ifTrue: [ self commonSend. ]
		ifFalse: [
					
			((self fetchClassOf: result) = (objectMemory splObj: ClassPrototype))
				ifTrue: [
					index := 0.
					
					" process parent slots as messgaes "
					
					[ currentSlot := self fetchPointer: index ofObject: result.
					currentSlot = self nilObject. ]
						whileFalse: [ 
							" read message "

							(currentSlot = messageSelector) 
								ifTrue: [
									" push value of slot "
									self internalPop: 1 thenPush: (self fetchPointer: index+2 ofObject: result).
									self fetchNextBytecode.
									^ self.].
				 
							" write message "
							currentSlot := self fetchPointer: index+1 ofObject: result.			
							(currentSlot = messageSelector) 
								ifTrue: [ 
									" write value to slot "
									argument := self internalStackTop.
									self internalPop: 2.
									self storePointer: index+2 ofObject: result withValue: argument. 
									self internalPush: result.
									self fetchNextBytecode.
									^ self ].

								index := index + 3 ].
					
					index := index + 1.

					" process method slots "
					
					[ currentSlot := self fetchPointer: index ofObject: result.
					currentSlot = self nilObject. ]
						whileFalse: [
							(currentSlot = messageSelector) 
								ifTrue: [ 
									"primitiveIndex := 0."
									newMethod := self fetchPointer: index+1 ofObject: result.
									lkupClass := (objectMemory splObj: ClassPrototype).
									self internalExecuteNewMethod.
									self fetchNextBytecode.
									^ self.].
								  index := index + 2 ].

					index := index + 1.

					" process data slots "

					[ currentSlot := self fetchPointer: index ofObject: result.
					currentSlot = self nilObject. ]
						whileFalse: [ 
							" read message "

							(currentSlot = messageSelector) 
								ifTrue: [
									" push value of slot "
									self internalPop: 1 thenPush: (self fetchPointer: index+2 ofObject: result).
									self fetchNextBytecode.
									^ self.].
				 
							" write message "
							currentSlot := self fetchPointer: index+1 ofObject: result.			
							(currentSlot = messageSelector) 
								ifTrue: [ 
									" write value to slot "
									argument := self internalStackTop.
									self internalPop: 2.
									self storePointer: index+2 ofObject: result withValue: argument. 
									self internalPush: result.
									self fetchNextBytecode.
									^ self ].

								index := index + 3 ] ]
				ifFalse: [ 
					" standard object"
					self longAt: localSP - (argumentCount * 4) put: result.
					lkupClass := self fetchClassOf: result.				
					self commonSend.
				] ].
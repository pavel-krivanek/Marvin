as yet unclassified
delegationSend

	| rcvr result index currentSlot argument |

	self inline: true.
		
	rcvr := self internalStackValue: argumentCount.
	
	"I have to use sack or C generator uses it only as local"
	sack at: 1 put: 0. 
	sackPosition := 0.
	
	result := self findSlot: messageSelector in: rcvr.
	
	(result = objectMemory nilObject)
		ifTrue: [ self print: 'result is nil'; cr.. self commonSend. ]
		ifFalse: [
			self print: 'result not nil'; cr.. 
			((objectMemory fetchClassOf: result) = (objectMemory splObj: ClassPrototype))
				ifTrue: [
					self print: 'result is Prototype'; cr. 
					index := 0.
					
					"  process parent slots as messgaes  "

					[ currentSlot := objectMemory fetchPointer: index ofObject: result.
					currentSlot = objectMemory nilObject. ]
						whileFalse: [ 
							" read message "

							(currentSlot = messageSelector) 
								ifTrue: [
									" push value of slot "
									self internalPop: 1 thenPush: (objectMemory fetchPointer: index+2 ofObject: result).
									self fetchNextBytecode.
									^ self.].
				 
							" write message "
							currentSlot := objectMemory fetchPointer: index+1 ofObject: result.			
							(currentSlot = messageSelector) 
								ifTrue: [ 
									" write value to slot "
									argument := self internalStackTop.
									self internalPop: 2.
									objectMemory storePointer: index+2 ofObject: result withValue: argument. 
									self internalPush: result.
									self fetchNextBytecode.
									^ self ] .
								
							index := index + 3 ].
						
					index := index + 1.						

					" process method slots "
					
					[ currentSlot := objectMemory fetchPointer: index ofObject: result.
					currentSlot = objectMemory nilObject. ]
						whileFalse: [
							(currentSlot = messageSelector) 
								ifTrue: [ 
									"primitiveIndex := 0."
									newMethod := objectMemory fetchPointer: index+1 ofObject: result.
									lkupClass := (objectMemory splObj: ClassPrototype).
									self internalExecuteNewMethod.
									self fetchNextBytecode.
									^ self.].
								  index := index + 2 ].

					index := index + 1.

					" process data slots "

					[ currentSlot := objectMemory fetchPointer: index ofObject: result.
					currentSlot = objectMemory nilObject. ]
						whileFalse: [ 
							" read message "

							(currentSlot = messageSelector) 
								ifTrue: [
									" push value of slot "
									self internalPop: 1 thenPush: (objectMemory fetchPointer: index+2 ofObject: result).
									self fetchNextBytecode.
									^ self.].
				 
							" write message "
							currentSlot := objectMemory fetchPointer: index+1 ofObject: result.			
							(currentSlot = messageSelector) 
								ifTrue: [ 
									" write value to slot "
									argument := self internalStackTop.
									self internalPop: 2.
									objectMemory storePointer: index+2 ofObject: result withValue: argument. 
									self internalPush: result.
									self fetchNextBytecode.
									^ self ].

							index := index + 3 ] ]
				ifFalse: [ 
					self print: 'result is normal object'; cr. 
					" standard object"
					self longAt: localSP - (argumentCount * 4) put: result.
					lkupClass := objectMemory fetchClassOf: result.				
					self commonSend.
				] ].
					

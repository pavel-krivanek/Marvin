Class {
	#name : #MarvinInterpreter,
	#superclass : #StackInterpreterPrimitives,
	#instVars : [
		'sack',
		'sackPosition'
	],
	#classVars : [
		'ClassPrototype',
		'SackSize'
	],
	#category : 'Marvin-VM'
}

{ #category : #'as yet unclassified' }
MarvinInterpreter class >> declareCVarsIn: aCCodeGenerator [

	super declareCVarsIn: aCCodeGenerator.
	aCCodeGenerator
		var: #sack
		declareC: 'int sack[', (SackSize + 1) printString, ']'.
]

{ #category : #'as yet unclassified' }
MarvinInterpreter class >> initializeCaches [

	super initializeCaches.
		
	SackSize := 512.
	ClassPrototype := 40.

]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> commonSendAbsentImplicit [
	"Send a message to the implicit receiver for that message."
	"Assume: messageSelector and argumentCount have been set, and that 
	the arguments but not the receiver have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	"160-175	1010 i i i i		Send To Absent Implicit Receiver Literal Selector #iiii With 0 Arguments"
	"240		11110000	i i i i i j j j	Send To Absent Implicit Receiver Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	<sharedCodeNamed: 'commonSendAbsentImplicit' inCase: #extSendAbsentImplicitBytecode>
	| implicitReceiver |
	implicitReceiver := self
							implicitReceiverFor: self receiver
							mixin: (self methodClassOf: method)
							implementing: messageSelector.
	self shuffleArgumentsAndStoreAbsentReceiver: implicitReceiver.
	lkupClass := objectMemory fetchClassOf: implicitReceiver.
	self assert: lkupClass ~= objectMemory nilObject.
	lkupClass = (objectMemory splObj: ClassPrototype)
		ifTrue: [ self delegationSend ]
		ifFalse: [ self commonSend. ]
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> delegationResend [

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
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> delegationSend [

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
					

]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> dynamicSuperSendBytecode [
"Send a message to self, starting lookup in the superclass of the method application of the currently executing method's mixin."
"Assume: messageSelector and argumentCount have been set, and that the receiver and arguments have been pushed onto the stack," 
"WE WANT THE RECEIVER PUSHED IMPLICITLY, BUT IT IS NOT - SO FAR"
"Note: This method is inlined into the interpreter dispatch loop."
	| rcvr mClassMixin mixinApplication |
	<inline: true>
	argumentCount := self fetchByte.
	messageSelector := self literal: self fetchByte.
	rcvr := self internalStackValue: argumentCount.
	mClassMixin := self methodClassOf: method.
	mixinApplication := self 
		findApplicationOfTargetMixin: mClassMixin
		startingAtBehavior: (objectMemory fetchClassOf: rcvr).
	lkupClass := self superclassOf: mixinApplication.
	lkupClass = (objectMemory splObj: ClassPrototype)
		ifTrue: [ self printOop:  (objectMemory splObj: ClassPrototype) . self commonSend.  " self delegationSend " ]
		ifFalse: [ self commonSend. ]
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> extSendAbsentDynamicSuperBytecode [
	"241		11110001	i i i i i j j j	Send To Dynamic Superclass Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	| byte mClassMixin mixinApplication |
	byte := self fetchByte.
	messageSelector := self literal: (byte >> 3) + (extA << 5).
	extA := 0.
	argumentCount := (byte bitAnd: 7) + (extB << 3).
	extB := 0.
	self shuffleArgumentsAndStoreAbsentReceiver: self receiver.
	mClassMixin := self methodClassOf: method.
	mixinApplication := self 
							findApplicationOfTargetMixin: mClassMixin
							startingAtBehavior: (objectMemory fetchClassOf: self receiver).
	lkupClass := self superclassOf: mixinApplication.
	lkupClass = (objectMemory splObj: ClassPrototype)
		ifTrue: [ self delegationSend ]
		ifFalse: [ self commonSend. ]
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> extSendBytecode [
	"238		11101110	i i i i i j j j	Send Literal Selector #iiiii (+ Extend A * 32) with jjj (+ Extend B * 8) Arguments"
	| byte rcvr |
	byte := self fetchByte.
	messageSelector := self literal: (byte >> 3) + (extA << 5).
	extA := 0.
	argumentCount := (byte bitAnd: 7) + (extB << 3).
	extB := 0.
	rcvr := self internalStackValue: argumentCount.
	lkupClass := objectMemory fetchClassOf: rcvr.
	self assert: lkupClass ~= objectMemory nilObject.
	lkupClass = (objectMemory splObj: ClassPrototype)
		ifTrue: [ self delegationSend ]
		ifFalse: [ self commonSend. ]
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> findSlot: msgSelector in: obj [

	| index currentSlot currentParent found objClass |

	self inline: false.

	objClass := objectMemory fetchClassOf:  obj.

	1 to: sackPosition do: [ :pos | 
		(sack at: pos) = obj ifTrue: [ ^ objectMemory nilObject ] ].	

	objClass = (objectMemory splObj: ClassPrototype) 
		ifFalse: [
			lkupClass := objClass.
			"self internalFindNewMethod."
			(self messageImplementedByClass: objClass )
				ifTrue: [ ^ obj]
				ifFalse: [
					sackPosition := sackPosition +1.
					sackPosition > SackSize ifTrue: [ self error: 'prototypes buffer overflow' ].
					sack at: sackPosition put: obj. 
					^ objectMemory nilObject. ] ].

	index := 0.
	
	" process parent slots as messgaes "

	[ currentSlot := objectMemory fetchPointer: index ofObject: obj.
	currentSlot = objectMemory nilObject. ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) ifTrue: [ ^ obj ].
 			" write message "
			currentSlot := objectMemory fetchPointer: index+1 ofObject: obj.			
			(currentSlot = messageSelector) ifTrue: [ ^ obj ].

			index := index + 3 ].

	index := index + 1.

	" process method slots "

	[ currentSlot := objectMemory fetchPointer: index ofObject: obj.
	currentSlot = objectMemory nilObject. ]
		whileFalse: [	 
			(currentSlot = messageSelector) ifTrue: [ ^ obj ]. 
			index := index + 2 ].
		
	index := index + 1.

	" process data slots "

	[ currentSlot := objectMemory fetchPointer: index ofObject: obj.
	currentSlot = objectMemory nilObject. ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) ifTrue: [ ^ obj ].
 			" write message "
			currentSlot := self fetchPointer: index+1 ofObject: obj.			
			(currentSlot = messageSelector) 
				ifTrue: [ ^ obj ].

			index := index + 3 ].

	" add to sack "
	
	sackPosition := sackPosition +1.
	sackPosition > SackSize ifTrue: [ self error: 'prototypes buffer overflow' ].
	sack at: sackPosition put: obj.

	" find in parents "

	index := 0.

	[ currentSlot := objectMemory fetchPointer: index ofObject: obj.
	currentSlot = objectMemory nilObject. ]
		whileFalse: [
			currentParent := (objectMemory fetchPointer: index+2 ofObject: obj).
			found := self findSlot: msgSelector in: currentParent.
			found = objectMemory nilObject ifFalse: [ ^ found ].
			index := index + 3].

	^ objectMemory nilObject.

]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> findSlot: msgSelector inParentsOf: obj [

	| index currentSlot currentParent found |

	self inline: false.
	
	index := 0.

	[ currentSlot := self fetchPointer: index ofObject: obj.
	currentSlot = self nilObject. ]
		whileFalse: [
			currentParent := (self fetchPointer: index+2 ofObject: obj).
			((self fetchClassOf: currentParent)  = (objectMemory splObj: ClassPrototype))
				ifTrue: [	 
					found := self findSlot: msgSelector in: currentParent.
					found = self nilObject ifFalse: [ ^ found ]].
			index := index + 3 ].

	^ self nilObject.

]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> messageImplementedByClass: class [

	| currentClass dictionary found |
	
	self inline: false.

	"currentClass := class.
	[currentClass ~= objectMemory nilObject]
		whileTrue:
		[dictionary := self fetchPointer: MessageDictionaryIndex ofObject: currentClass.
		dictionary = objectMemory nilObject ifTrue: [ ^ self falseObject ].
		found := self lookupMethodInDictionary: dictionary.
		found ifTrue: [ ^ self trueObject ].
		currentClass := self superclassOf: currentClass]."
	
	^ self falseObject.
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> normalSend [
	"Send a message, starting lookup with the receiver's class."
	"Assume: messageSelector and argumentCount have been set, and that 
	the receiver and arguments have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	<sharedCodeNamed: 'normalSend' inCase: #singleExtendedSendBytecode>
	| rcvr |
	rcvr := self internalStackValue: argumentCount.
	lkupClass := objectMemory fetchClassOf: rcvr.
	self assert: lkupClass ~= objectMemory nilObject.
	"self commonSend."

	lkupClass = (objectMemory splObj: ClassPrototype)
		ifTrue: [ self delegationSend ]
		ifFalse: [ self commonSend. ]
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> sendLiteralSelector0ArgsBytecode [
	"Can use any of the first 16 literals for the selector."
	| rcvr |
	messageSelector := self literal: (currentBytecode bitAnd: 16rF).
	argumentCount := 0.
	rcvr := self internalStackValue: 0.
	lkupClass := objectMemory fetchClassOf: rcvr.
	self assert: lkupClass ~= objectMemory nilObject.
	lkupClass = (objectMemory splObj: ClassPrototype)
		ifTrue: [ self delegationSend ]
		ifFalse: [ self commonSend. ]
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> sendLiteralSelector1ArgBytecode [
	"Can use any of the first 16 literals for the selector."
	| rcvr |
	messageSelector := self literal: (currentBytecode bitAnd: 16rF).
	argumentCount := 1.
	rcvr := self internalStackValue: 1.
	lkupClass := objectMemory fetchClassOf: rcvr.
	self assert: lkupClass ~= objectMemory nilObject.
	lkupClass = (objectMemory splObj: ClassPrototype)
		ifTrue: [ self delegationSend ]
		ifFalse: [ self commonSend. ]
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> sendLiteralSelector2ArgsBytecode [
	"Can use any of the first 16 literals for the selector."
	| rcvr |
	messageSelector := self literal: (currentBytecode bitAnd: 16rF).
	argumentCount := 2.
	rcvr := self internalStackValue: 2.
	lkupClass := objectMemory fetchClassOf: rcvr.
	self assert: lkupClass ~= objectMemory nilObject.
	lkupClass = (objectMemory splObj: ClassPrototype)
		ifTrue: [ self delegationSend ]
		ifFalse: [ self commonSend. ]
]

{ #category : #'as yet unclassified' }
MarvinInterpreter >> superclassSend [
	"Send a message to self, starting lookup with the superclass of the class
	 containing the currently executing method."
	"Assume: messageSelector and argumentCount have been set, and that
	 the receiver and arguments have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	| rcvr |
	<sharedCodeNamed: 'commonSupersend' inCase: #singleExtendedSuperBytecode>
	lkupClass := self superclassOf: (self methodClassOf: method).
	self assert: lkupClass ~= objectMemory nilObject.

	rcvr := self internalStackValue: argumentCount.
	((self fetchClassOf: rcvr) = (objectMemory splObj: ClassPrototype))
		ifTrue: [ self delegationResend  ]
		ifFalse: [ self commonSend. ]
]

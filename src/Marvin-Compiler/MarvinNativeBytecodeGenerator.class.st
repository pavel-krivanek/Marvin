Class {
	#name : #MarvinNativeBytecodeGenerator,
	#superclass : #Object,
	#instVars : [
		'context',
		'arguments',
		'temporaries',
		'literals',
		'bytecodes',
		'contextLiteral',
		'returnSelf',
		'slotsDictionary'
	],
	#category : 'Marvin-Compiler'
}

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> addBytecode: byte [

	self parent bytecodes add: byte
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> addSlotsValues [

	contextLiteral slots do: [ :slot |
		slot isDataSlot ifTrue: [ 	
				| val |
				slot content 
					ifNotNil: [
						| gen method methodLiteral |
						slot content regenerate.
						gen := MarvinNativeBytecodeGenerator new.
						methodLiteral := MarvinMethodLiteral new.
						methodLiteral context: slot content.
						method := gen methodFrom: methodLiteral owner: MarvinPrototype lobby.
						val := gen runInLobby: method. 
	
						self parent literals add: val.
						slotsDictionary at: slot name put: val.
						].
			] ]
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> arguments [
	^arguments
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> argumentsAndTemporaries [
	
	^ arguments, temporaries
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcPop: instr [

	"popStackBytecode"
	
	self addBytecode: 135
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcPrimBlockCopy [

	"bytecodePrimBlockCopy" 
	
	self addBytecode: 200.
	
	
	
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcPushActiveContext [

	"pushActiveContextBytecode" 
	
	self addBytecode: 137.
	
	
	
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcPushLiteral: instr [

	| index literal |
	literal := instr second. 

	literal isConstantLiteral ifTrue: [
		index := self parent literals indexOf: instr second content ].

	literal isObjectLiteral ifTrue: [
		| obj |
		obj := (self createObjectFrom: literal).
		self parent literals add: obj.
		index := self parent literals indexOf: obj ].
	
	"pushLiteralConstantBytecode"
	self addBytecode: 31 + index. 
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcPushNil: instr [

	"pushConstantNilBytecode"
	
	self addBytecode: 115
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcPushSelf: instr [

	"pushReceiverBytecode"
	
	self addBytecode: 112
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcResend: instr [

	| index |
	index := self parent literals indexOf: instr second ifAbsent: [ self error: 'selector literal not found' ].

	"singleExtendedSendBytecode" 
	
	self addBytecode: 133.
	self addBytecode: (index - 1 bitOr:  instr third << 5).
	
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcReturnImplicit: instr [
	
	self returnSelf 
		ifTrue: [
			"popStackBytecode"
			self addBytecode: 135.

			"returnReceiver"
			self addBytecode: 120 ]
		ifFalse: [
			self context instructions size = 1 
				ifTrue: [ "empty block" 
					self bcPushNil: nil.
					"returnTopFromBlock"
					self addBytecode: 125]
				ifFalse: [ 
					"returnTopFromBlock"
					self addBytecode: 125 ] ].
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcReturnTop: instr [

	"returnTopFromMethod"
	self addBytecode: 124
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcSelfSend: instr [

	| tempIndex |
	
	"osetreni lokalnich lokalnich data slotu jako docasnych promennych"

	" read "
	tempIndex := (self parent argumentsAndTemporaries indexOf: instr second).
	tempIndex > 0 ifTrue: [
			self bcPop: nil.
			"pushTemporaryVariableBytecode"
			self addBytecode: 15+tempIndex. 
			^ self. ].
	
	" write "
	(instr second last = $:) ifTrue: [ 
		| name | 
		name := instr second allButLast.
		" cannot write into arguments "
		tempIndex := (self parent emptyArgumentsAndTemporaries indexOf: name ).
		tempIndex > 0 ifTrue: [.
				"storeAndPopTemporaryVariableBytecode"
				self addBytecode: 103+tempIndex.
				self bcPop: nil.
				
				"sending simulation - have to return value to the stack" 
				"pushTemporaryVariableBytecode"
				self addBytecode: 15+tempIndex. 

				^ self. ] ].

	^ self bcSend: instr.
]

{ #category : #bytecodes }
MarvinNativeBytecodeGenerator >> bcSend: instr [

	| index |
	index := self parent literals indexOf: instr second ifAbsent: [ self error: 'selector literal not found' ].

	"singleExtendedSendBytecode" 
	
	self addBytecode: 131.
	self addBytecode: (index - 1 bitOr:  instr third << 5).
	
	
	
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> bytecodes [
	^bytecodes
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> bytecodes: anObject [
	bytecodes := anObject
]

{ #category : #method }
MarvinNativeBytecodeGenerator >> compiledMethodForOwner: owner [

	| methodLiterals aCompiledMethod additionalMethodState |

	methodLiterals := self literals asOrderedCollection.
"	methodLiterals add: MarvinPrototype.
"	
	additionalMethodState := AdditionalMethodState forMethod: nil selector: #someSelector.
	methodLiterals add: additionalMethodState.
	methodLiterals add: (	Smalltalk bindingOf: #MarvinPrototype).
		
	aCompiledMethod := CompiledMethod
		primitive: 0
		numArgs: self arguments size
		numTemps: (self temporaries size +self arguments size)
		stackSize: 0
		literals: methodLiterals
		bytecodes: self bytecodes
		trailer:  CompiledMethodTrailer empty.
		
	additionalMethodState method: aCompiledMethod.
		
"	aCompiledMethod literalAt: methodLiterals size put: (AdditionalMethodState new).
"	aCompiledMethod properties at: #owningObject put: owner.

	^ aCompiledMethod
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> context [
	^ contextLiteral context
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> context: anObject [
	contextLiteral context: anObject
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> contextLiteral [
	^contextLiteral
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> contextLiteral: anObject [
	contextLiteral := anObject
]

{ #category : #objects }
MarvinNativeBytecodeGenerator >> createObjectFrom: literal [

	| object |

	object := MarvinPrototype new.	

	literal slots do: [ :slot |
		slot type = #readSlot
			ifTrue: [ 	
				| val |
				slot content 
					ifNotNil: [
						| gen method methodLiteral |
						slot content regenerate.
						gen := MarvinNativeBytecodeGenerator new.
						methodLiteral := MarvinMethodLiteral new.
						methodLiteral context: slot content.
						method := gen methodFrom: methodLiteral owner: object.
						val := gen runInLobby: method. ].
				object _AddReadSlot: slot name asSymbol value:  val.
			].

		slot type = #assignSlot
			ifTrue: [ 	
				| val |
				slot content 
					ifNotNil: [
						| gen method methodLiteral |
						slot content regenerate.
						gen := MarvinNativeBytecodeGenerator new.
						methodLiteral := MarvinMethodLiteral new.
						methodLiteral context: slot content.
						method := gen methodFrom: methodLiteral owner: object.
						val := gen runInLobby: method. ].
				object _AddAssignSlot: slot name asSymbol value:  val.
			].

		slot type = #methodSlot
			ifTrue: [ 	
				| method |
				slot content
					ifNotNil: [
						| methodLiteral |
						methodLiteral := slot content.
						method := MarvinNativeBytecodeGenerator new methodFrom: methodLiteral owner: object. ].
				object _AddMethodSlot: slot name asSymbol value:  method.
			].
		((slot type = #parentSlot) | (slot type = #readWriteParentSlot))
			ifTrue: [ 	
				| val |
				slot content 
					ifNotNil: [
						| gen method methodLiteral |
						slot content regenerate.
						gen := MarvinNativeBytecodeGenerator new.
						gen returnSelf: false.
						methodLiteral := MarvinMethodLiteral new.
						methodLiteral context: slot content.
						method := gen methodFrom: methodLiteral owner: object..
						val := gen runInLobby: method. ].
				slot type = #parentSlot
					ifTrue: [ object _AddParentSlot: slot name allButLast asSymbol value:  val]
					ifFalse: [ object _AddReadWriteParentSlot: slot name allButLast asSymbol value:  val ].
			]
	 ].

	"{ literal. object } explore."

	^ object.
	
	
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> emptyArgumentsAndTemporaries [
	
	^ (Array ofSize: arguments size), temporaries
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> generateCode [

	self parent literals addAll: self context selectors.
	self parent literals addAll: self context literals.
	self addSlotsValues.

	self contextLiteral slots do: [ :slot |
		slot type = #argumentSlot
			ifTrue: [ 
				self parent arguments add: slot name ].
					slot isDataSlot
				ifTrue: [
					| literal slotValue |
					slotValue := slotsDictionary at: slot name ifAbsent: [].
					slotValue 
						ifNotNil: [
							literal := MarvinConstantLiteral for: slotValue.
							self parent temporaries add: slot name.
							self bcPushLiteral:  {nil. literal }.
							"storeAndPopTemporaryVariableBytecode"
							self addBytecode: 103+ (self parent emptyArgumentsAndTemporaries indexOf: slot name )..
							 ]
						ifNil: [self parent temporaries add: slot name. ]
					 ] ].

	self translate: self context instructions.
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> initialize [

	super initialize.
	
	arguments := OrderedCollection new.
	temporaries := OrderedCollection new.
	literals := OrderedCollection new.
	bytecodes := OrderedCollection new.
	slotsDictionary := Dictionary new.
	returnSelf := true.

]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> literals [
	^literals
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> literals: anObject [
	literals := anObject
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> methodFrom: aContext owner: aPrototype [

	| method |
	
	contextLiteral := aContext.
	
	self literals: aContext context selectors copy.
	self literals addAll: aContext context literals.
	
	self generateCode.
	
	method := self compiledMethodForOwner: aPrototype.
	
	Transcript show: method symbolic; cr; cr.

	^ method.




]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> parent [

	^ self
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> processLiteral: instruction [

	| literal |

	literal := instruction second.
	
	literal isBlockLiteral ifTrue: [
		| generator |
		generator := MarvinNativeBlockBytecodeGenerator new.
		generator parent: self parent.
		generator contextLiteral: literal.
		generator context: literal context.
		generator generateCode.
		^ self ].
	
	self bcPushLiteral: instruction.
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> returnSelf [
	^returnSelf
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> returnSelf: anObject [
	returnSelf := anObject
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> runInLobby: method [

	| lobby |

	lobby := MarvinPrototype lobby.

	lobby _RemoveSlot: #DoIt.
	
	lobby _AddMethodSlot: #DoIt value: method.

	^ lobby DoIt




]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> standardLiterals: literalsCollection [

	^ literalsCollection select: [ :lit | lit isBlockLiteral not ].
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> temporaries [
	^temporaries
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> temporaries: anObject [
	temporaries := anObject
]

{ #category : #accessing }
MarvinNativeBytecodeGenerator >> translate: instructions [ 

	instructions do: [ :instr | 
		instr ifNotNil: [
			instr first caseOf: { 
				[#send:] -> [self bcSend: instr].
				[#selfSend:] -> [self bcSelfSend: instr].
				[#resend:] -> [self bcResend: instr].
				[#pushSelf] -> [self bcPushSelf: instr].
				[#pushLiteral:] -> [self processLiteral: instr].
				[#pop] -> [self bcPop: instr].
				[#returnTop] -> [self bcReturnTop: instr].
				[#returnImplicit] -> [self bcReturnImplicit: instr]} ] ]
]

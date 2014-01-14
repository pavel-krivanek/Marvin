as yet unclassified
generateCode

	| numArgsLiteral |

	self parent literals addAll: self context selectors.
	self parent literals addAll: self context literals.
	self addSlotsValues.

	" header "
	self bcPushActiveContext.
	numArgsLiteral := MarvinConstantLiteral for: self contextLiteral numArguments.
	self parent literals add: self contextLiteral numArguments.
	self bcPushLiteral:  {nil. numArgsLiteral }.
	self bcPrimBlockCopy. 

	self jumpAcross: [

		"fill argumet temps from stack"

		(self contextLiteral numArguments-1) to: 0 by: -1 do: [ :argIndex |
			"storeAndPopTemporaryVariableBytecode"
			self addBytecode: 104+argIndex.].
			

		self contextLiteral slots do: [ :slot |
			slot type = #argumentSlot
				ifTrue: [
					self parent arguments add: slot name allButFirst "begins with $:" ].
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
					 ].
		].
		self translate: self context instructions. ].


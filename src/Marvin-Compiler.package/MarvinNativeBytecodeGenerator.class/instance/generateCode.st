accessing
generateCode

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
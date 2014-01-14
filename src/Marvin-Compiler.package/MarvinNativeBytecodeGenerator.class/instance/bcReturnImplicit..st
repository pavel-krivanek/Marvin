bytecodes
bcReturnImplicit: instr
	
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
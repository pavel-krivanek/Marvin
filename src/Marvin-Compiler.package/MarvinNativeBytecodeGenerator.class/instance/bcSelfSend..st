bytecodes
bcSelfSend: instr

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
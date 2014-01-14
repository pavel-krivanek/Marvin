bytecodes
bcSend: instr

	| index |
	index := self parent literals indexOf: instr second ifAbsent: [ self error: 'selector literal not found' ].

	"singleExtendedSendBytecode" 
	
	self addBytecode: 131.
	self addBytecode: (index - 1 bitOr:  instr third << 5).
	
	
	
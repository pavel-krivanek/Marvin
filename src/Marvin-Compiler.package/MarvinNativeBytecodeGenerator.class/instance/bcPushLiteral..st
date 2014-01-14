bytecodes
bcPushLiteral: instr

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
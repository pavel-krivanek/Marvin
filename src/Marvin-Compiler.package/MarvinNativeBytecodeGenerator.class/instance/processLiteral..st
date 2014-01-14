accessing
processLiteral: instruction

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
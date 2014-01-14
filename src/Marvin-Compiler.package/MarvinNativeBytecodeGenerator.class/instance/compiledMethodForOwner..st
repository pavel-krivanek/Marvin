method
compiledMethodForOwner: owner

	| methodLiterals |

	methodLiterals := self literals asOrderedCollection.
	methodLiterals add: owner.

	^ CompiledMethod
		primitive: 0
		numArgs: self arguments size
		numTemps: (self temporaries size +self arguments size)
		stackSize: 0
		literals: methodLiterals
		bytecodes: self bytecodes
		trailer:  CompiledMethodTrailer empty.
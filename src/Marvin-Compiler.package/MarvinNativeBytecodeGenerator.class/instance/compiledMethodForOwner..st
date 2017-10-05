method
compiledMethodForOwner: owner

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
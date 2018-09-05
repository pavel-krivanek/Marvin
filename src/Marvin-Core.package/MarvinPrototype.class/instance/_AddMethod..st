slots
_AddMethod: aSourceCode

	| compiledMethod |
	
	compiledMethod := OpalCompiler new 
		class: MarvinPrototype;
		source: aSourceCode;
		failBlock: [ ^ nil ];
		compile.
		
	compiledMethod propertyAt: #owningObject put: self.
	
	^ self _AddMethodSlot: compiledMethod selector value: compiledMethod
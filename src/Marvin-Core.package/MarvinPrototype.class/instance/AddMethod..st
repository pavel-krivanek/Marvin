slots
AddMethod: aSourceCode

	| compiledMethod |
	
	compiledMethod := OpalCompiler new 
		class: MarvinPrototype;
		source: aSourceCode;
		failBlock: [ ^ nil ];
		compile.
		
	compiledMethod propertyAt: #owningObject put: self.
	
	^ self AddMethodSlot: compiledMethod selector value: compiledMethod
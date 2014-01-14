generating
codeContext: aCollection 

	| val gen method methodLiteral |
	
	methodLiteral := MarvinMethodLiteral new.

	(aCollection size = 2) 
		ifTrue: [ 
			methodLiteral slots: aCollection first value.
			methodLiteral context: aCollection second value ].

	(aCollection size = 1) 
		ifTrue: [ 
			(aCollection first value isCollection )
				ifTrue: [
					methodLiteral slots: aCollection first value. ]
				ifFalse: [
					methodLiteral context: aCollection first value ] ].

	gen := MarvinNativeBytecodeGenerator new.
	gen returnSelf: false.

	method := gen methodFrom: methodLiteral owner: MarvinPrototype lobby.
	val := gen runInLobby: method.

	^ val

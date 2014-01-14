generating
method: aCollection

	| methodLiteral |
	
	methodLiteral := MarvinMethodLiteral new.
	
	aCollection size = 2
		ifTrue: [ ^ methodLiteral ].
	
	(aCollection size = 3) 
		ifTrue: [ 
			(aCollection second value isCollection )
				ifTrue: [
					methodLiteral slots: aCollection second value. ]
				ifFalse: [
					methodLiteral context: aCollection second value ] ].

	(aCollection size = 4) 
		ifTrue: [ 
			methodLiteral slots: aCollection second value.
			methodLiteral context: aCollection third value ].

	^ methodLiteral.
	


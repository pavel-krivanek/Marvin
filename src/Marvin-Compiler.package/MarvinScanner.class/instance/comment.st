scanning
comment
	| char |
	
	char := stream next.
	
	(char = $")
		ifTrue: [ 
			" single line comment"
			[((char := stream next) isNil 
				or: [char == Character cr])
				or: [char == Character lf]] whileFalse.
			^self whitespace.
		].
	" multiline comment "	
	[(char := stream next) isNil or: [char == $"]] whileFalse.		
	((char = nil) and: [stream atEnd])
		ifTrue: [self scannerError].
	
	^self whitespace.
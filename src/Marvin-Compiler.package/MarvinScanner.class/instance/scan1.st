generated-scanner
scan1
	self recordMatch: #(22).
	self step.
	((currentCharacter between: $A and: $Z) or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ 
			[ 
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z) or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
				whileTrue.
			currentCharacter = $:
				ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	^ self reportLastMatch
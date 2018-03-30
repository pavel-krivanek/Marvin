generated
scanForTokenX1X1
	[ self recordMatch: #(22).
	self step.
	currentCharacter == $:
		ifTrue: [ ^ self scan2 ].
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	^ self reportLastMatch
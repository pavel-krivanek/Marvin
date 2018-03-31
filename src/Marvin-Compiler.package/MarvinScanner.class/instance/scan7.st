generated
scan7
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			currentCharacter between: $0 and: $9 ] whileTrue ].
	^ self reportLastMatch
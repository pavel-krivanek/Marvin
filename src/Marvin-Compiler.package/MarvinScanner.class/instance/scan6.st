generated
scan6
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter between: $0 and: $9 ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter == Character space
		or:
			[ '+-|' includes: currentCharacter ])
		ifTrue: [ ^ self scan7 ].
	^ self reportLastMatch
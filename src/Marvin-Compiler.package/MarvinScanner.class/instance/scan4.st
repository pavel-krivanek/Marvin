generated
scan4
	[ self recordMatch: #(20).
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $e
		ifTrue: [ ^ self scan6 ].
	currentCharacter == $r
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ currentCharacter between: $A and: $Z ])
				ifTrue: [ ^ self scan8 ].
			^ self reportLastMatch ].
	currentCharacter between: $0 and: $9 ] whileTrue.
	(currentCharacter between: $A and: $Z)
		ifTrue: [ ^ self scan8 ].
	^ self reportLastMatch
generated
scan8
	[ self recordMatch: #(20).
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $e
		ifTrue: [ ^ self scan6 ].
	(currentCharacter between: $0 and: $9)
		or: [ currentCharacter between: $A and: $Z ] ] whileTrue.
	^ self reportLastMatch
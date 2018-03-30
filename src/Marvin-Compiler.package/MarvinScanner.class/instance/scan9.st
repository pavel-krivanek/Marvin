generated
scan9
	self recordMatch: #(13).
	self step.
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
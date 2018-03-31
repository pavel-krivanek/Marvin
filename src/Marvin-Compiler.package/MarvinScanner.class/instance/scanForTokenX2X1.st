generated
scanForTokenX2X1
	self recordMatch: #(13).
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	currentCharacter == $:
		ifTrue: [ ^ self scan9 ].
	(currentCharacter between: $0 and: $9)
		ifTrue: [ [ self recordMatch: #(13 20).
			self step.
			currentCharacter == $*
				ifTrue: [ ^ self recordAndReportMatch: #(14) ].
			currentCharacter == $:
				ifTrue: [ ^ self scan9 ].
			currentCharacter between: $0 and: $9 ] whileTrue.
			((currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ ^ self scan11 ].
			^ self reportLastMatch ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ ^ self scan11 ].
	(currentCharacter == Character space
		or:
			[ '+-|' includes: currentCharacter ])
		ifTrue: [ ^ self scan7 ].
	^ self reportLastMatch
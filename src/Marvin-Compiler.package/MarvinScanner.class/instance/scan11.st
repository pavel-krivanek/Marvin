generated
scan11
	[ self recordMatch: #(13).
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	currentCharacter == $:
		ifTrue: [ ^ self scan9 ].
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	^ self reportLastMatch
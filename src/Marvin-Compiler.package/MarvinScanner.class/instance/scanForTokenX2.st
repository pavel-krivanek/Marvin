generated
scanForTokenX2
	[ self recordMatch: #(11 18).
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter == $.
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan9 ].
	currentCharacter == $e
		ifTrue:
			[ ^ self scanForTokenX2X1 ].
	(currentCharacter between: $0 and: $9)
		or: [ currentCharacter between: $A and: $Z ] ] whileTrue.
	(currentCharacter == $_
		or: [ (currentCharacter between: $a and: $d)
				or: [ currentCharacter between: $f and: $z ] ])
		ifTrue: [ ^ self scan11 ].
	^ self reportLastMatch
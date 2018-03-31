generated
scanForTokenX1
	self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan1 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue:
			[ ^ self scanForTokenX1X1 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(24).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $$ and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $; and: $@)
												or: [ '\~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
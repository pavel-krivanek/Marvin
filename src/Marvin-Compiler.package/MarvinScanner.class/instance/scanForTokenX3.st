generated
scanForTokenX3
	self recordMatch: #(18).
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self scan4 ].
	(currentCharacter between: $A and: $Z)
		ifTrue: [ ^ self scan8 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $$ and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $; and: $@)
												or: [ '\~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
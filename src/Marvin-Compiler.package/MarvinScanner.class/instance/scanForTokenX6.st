generated
scanForTokenX6
	[ self recordMatch: #(18).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ] ] whileTrue
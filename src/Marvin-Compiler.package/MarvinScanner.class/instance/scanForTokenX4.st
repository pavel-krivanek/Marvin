generated
scanForTokenX4
	self recordMatch: #(16).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ self recordMatch: #(16 17).
			self step.
			(currentCharacter == $!
				or: [ (currentCharacter between: $$ and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $; and: $@)
												or: [ '\~' includes: currentCharacter ] ] ] ] ])
				ifTrue: [ [ self recordMatch: #(16).
					self step.
					currentCharacter == $!
						or: [ (currentCharacter between: $$ and: $&)
								or: [ (currentCharacter between: $* and: $-)
										or: [ currentCharacter == $/
												or: [ (currentCharacter between: $; and: $@)
														or: [ '\~' includes: currentCharacter ] ] ] ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	^ self recordAndReportMatch: #(17)
generated
scanForTokenX4
	self recordMatch: #(18).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ self recordMatch: #(18 19).
			self step.
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
			^ self reportLastMatch ].
	^ self recordAndReportMatch: #(19)
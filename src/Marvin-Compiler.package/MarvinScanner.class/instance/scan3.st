generated
scan3
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(21).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan3 ].
			^ self reportLastMatch ].
	true ] whileTrue
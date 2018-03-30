generated
scanForTokenX8
	[ self recordMatch: #(24).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
generated-scanner
scan11
	[ 
	self step.
	currentCharacter ~= $' ] whileTrue.
	currentCharacter = $'
		ifTrue: [ 
			self recordMatch: #(21).
			self step.
			currentCharacter = $'
				ifTrue: [ ^ self scan11 ].
			^ self reportLastMatch ].
	^ self reportLastMatch
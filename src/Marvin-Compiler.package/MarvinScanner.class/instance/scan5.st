generated-scanner
scan5
	self step.
	((currentCharacter between: $0 and: $9) or: [ currentCharacter between: $A and: $Z ])
		ifTrue: [ 
			[ 
			self recordMatch: #(18).
			self step.
			(currentCharacter between: $0 and: $9) or: [ currentCharacter between: $A and: $Z ] ] whileTrue.
			currentCharacter = $e
				ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	^ self reportLastMatch
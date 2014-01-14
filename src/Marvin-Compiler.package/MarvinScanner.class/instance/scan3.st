generated-scanner
scan3
	[ 
	self recordMatch: #(18).
	self step.
	(currentCharacter between: $A and: $Z)
		ifTrue: [ ^ self scan4 ].
	currentCharacter between: $0 and: $9 ] whileTrue.
	currentCharacter = $.
		ifTrue: [ ^ self scan5 ].
	currentCharacter = $e
		ifTrue: [ ^ self scan6 ].
	currentCharacter = $r
		ifTrue: [ 
			self step.
			((currentCharacter between: $0 and: $9) or: [ currentCharacter between: $A and: $Z ])
				ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	^ self reportLastMatch
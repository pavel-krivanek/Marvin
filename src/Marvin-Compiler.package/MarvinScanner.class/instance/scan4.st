generated-scanner
scan4
	[ 
	self recordMatch: #(18).
	self step.
	(currentCharacter between: $0 and: $9) or: [ currentCharacter between: $A and: $Z ] ] whileTrue.
	currentCharacter = $.
		ifTrue: [ ^ self scan5 ].
	currentCharacter = $e
		ifTrue: [ ^ self scan6 ].
	^ self reportLastMatch
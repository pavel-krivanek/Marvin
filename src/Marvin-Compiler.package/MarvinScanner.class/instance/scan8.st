generated-scanner
scan8
	[ 
	self recordMatch: #(11).
	self step.
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z) or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	currentCharacter = $*
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter = $:
		ifTrue: [ ^ self scan9 ].
	^ self reportLastMatch
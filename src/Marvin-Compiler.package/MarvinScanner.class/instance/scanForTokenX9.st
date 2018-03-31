generated
scanForTokenX9
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter == $|
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self scan4 ].
	(currentCharacter between: $A and: $Z)
		ifTrue:
			[ ^ self scanForTokenX2 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX8 ].
	currentCharacter isSafeForHTTP
		ifTrue: [ ^ self scan11 ].
	(currentCharacter isSpecial or: [ currentCharacter == $; ])
		ifTrue:
			[ self scanForTokenX6 ].
	^ self reportLastMatch
generated
scanForTokenX9
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $|
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
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
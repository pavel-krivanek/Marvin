generated
scanForToken
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(23) ].
	currentCharacter == $#
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $$
		ifTrue:
			[ ^ self scanForTokenX4 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	currentCharacter == $-
		ifTrue:
			[ ^ self scanForTokenX3 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $:
		ifTrue:
			[ ^ self scanForTokenX7 ].
	currentCharacter == $=
		ifTrue:
			[ ^ self scanForTokenX5 ].
	^ self scanForTokenX9
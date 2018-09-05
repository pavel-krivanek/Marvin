Class {
	#name : #MarvinScanner,
	#superclass : #SmaCCScanner,
	#category : 'Marvin-Compiler'
}

{ #category : #'generated-initialization' }
MarvinScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(18 '<-' 3) #(13 'resend' 21) #(13 'self' 22))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #scanning }
MarvinScanner >> comment [
	| char |
	
	char := stream next.
	
	(char = $")
		ifTrue: [ 
			" single line comment"
			[((char := stream next) isNil 
				or: [char == Character cr])
				or: [char == Character lf]] whileFalse.
			^self whitespace.
		].
	" multiline comment "	
	[(char := stream next) isNil or: [char == $"]] whileFalse.		
	((char = nil) and: [stream atEnd])
		ifTrue: [self scannerError].
	
	^self whitespace.
]

{ #category : #generated }
MarvinScanner >> emptySymbolTokenId [
	^ 62
]

{ #category : #generated }
MarvinScanner >> errorTokenId [
	^ 63
]

{ #category : #generated }
MarvinScanner >> scan1 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(24).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
MarvinScanner >> scan10 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(16).
			self step.
			((currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ ^ self scan10 ].
			^ self reportLastMatch ].
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scan11 [
	[ self recordMatch: #(13).
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	currentCharacter == $:
		ifTrue: [ ^ self scan9 ].
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scan2 [
	self recordMatch: #(24).
	self step.
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan2 ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scan3 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(23).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan3 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
MarvinScanner >> scan4 [
	[ self recordMatch: #(20).
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $e
		ifTrue: [ ^ self scan6 ].
	currentCharacter == $r
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ currentCharacter between: $A and: $Z ])
				ifTrue: [ ^ self scan8 ].
			^ self reportLastMatch ].
	currentCharacter between: $0 and: $9 ] whileTrue.
	(currentCharacter between: $A and: $Z)
		ifTrue: [ ^ self scan8 ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scan5 [
	self step.
	((currentCharacter between: $0 and: $9)
		or: [ currentCharacter between: $A and: $Z ])
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			currentCharacter == $e
				ifTrue: [ ^ self scan6 ].
			(currentCharacter between: $0 and: $9)
				or: [ currentCharacter between: $A and: $Z ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scan6 [
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			currentCharacter between: $0 and: $9 ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter == Character space
		or:
			[ '+-|' includes: currentCharacter ])
		ifTrue: [ ^ self scan7 ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scan7 [
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ [ self recordMatch: #(20).
			self step.
			currentCharacter between: $0 and: $9 ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scan8 [
	[ self recordMatch: #(20).
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $e
		ifTrue: [ ^ self scan6 ].
	(currentCharacter between: $0 and: $9)
		or: [ currentCharacter between: $A and: $Z ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scan9 [
	self recordMatch: #(15).
	self step.
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForToken [
	self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(25) ].
	currentCharacter == $#
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $$
		ifTrue:
			[ ^ self scanForTokenX4 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan3 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	currentCharacter == $-
		ifTrue:
			[ ^ self scanForTokenX3 ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $:
		ifTrue:
			[ ^ self scanForTokenX7 ].
	currentCharacter == $=
		ifTrue:
			[ ^ self scanForTokenX5 ].
	currentCharacter == $[
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	^ self scanForTokenX9
]

{ #category : #generated }
MarvinScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan1 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue:
			[ ^ self scanForTokenX1X1 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(24).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $$ and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $; and: $@)
												or: [ '\~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForTokenX1X1 [
	[ self recordMatch: #(24).
	self step.
	currentCharacter == $:
		ifTrue: [ ^ self scan2 ].
	(currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForTokenX2 [
	[ self recordMatch: #(13 20).
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	currentCharacter == $.
		ifTrue: [ ^ self scan5 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan9 ].
	currentCharacter == $e
		ifTrue:
			[ ^ self scanForTokenX2X1 ].
	(currentCharacter between: $0 and: $9)
		or: [ currentCharacter between: $A and: $Z ] ] whileTrue.
	(currentCharacter == $_
		or: [ (currentCharacter between: $a and: $d)
				or: [ currentCharacter between: $f and: $z ] ])
		ifTrue: [ ^ self scan11 ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForTokenX2X1 [
	self recordMatch: #(13).
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	currentCharacter == $:
		ifTrue: [ ^ self scan9 ].
	(currentCharacter between: $0 and: $9)
		ifTrue: [ [ self recordMatch: #(13 20).
			self step.
			currentCharacter == $*
				ifTrue: [ ^ self recordAndReportMatch: #(14) ].
			currentCharacter == $:
				ifTrue: [ ^ self scan9 ].
			currentCharacter between: $0 and: $9 ] whileTrue.
			((currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ ^ self scan11 ].
			^ self reportLastMatch ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ ^ self scan11 ].
	(currentCharacter == Character space
		or:
			[ '+-|' includes: currentCharacter ])
		ifTrue: [ ^ self scan7 ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForTokenX3 [
	self recordMatch: #(18).
	self step.
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self scan4 ].
	(currentCharacter between: $A and: $Z)
		ifTrue: [ ^ self scan8 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $$ and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $; and: $@)
												or: [ '\~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForTokenX4 [
	self recordMatch: #(18).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ self recordMatch: #(18 19).
			self step.
			(currentCharacter == $!
				or: [ (currentCharacter between: $$ and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $; and: $@)
												or: [ '\~' includes: currentCharacter ] ] ] ] ])
				ifTrue: [ [ self recordMatch: #(18).
					self step.
					currentCharacter == $!
						or: [ (currentCharacter between: $$ and: $&)
								or: [ (currentCharacter between: $* and: $-)
										or: [ currentCharacter == $/
												or: [ (currentCharacter between: $; and: $@)
														or: [ '\~' includes: currentCharacter ] ] ] ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	^ self recordAndReportMatch: #(19)
]

{ #category : #generated }
MarvinScanner >> scanForTokenX5 [
	self recordMatch: #(4 18).
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $$ and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $; and: $@)
												or: [ '\~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForTokenX6 [
	[ self recordMatch: #(18).
	self step.
	currentCharacter == $!
		or: [ (currentCharacter between: $$ and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $; and: $@)
										or: [ '\~' includes: currentCharacter ] ] ] ] ] ] whileTrue
]

{ #category : #generated }
MarvinScanner >> scanForTokenX7 [
	self step.
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(17).
			self step.
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForTokenX8 [
	[ self recordMatch: #(26).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MarvinScanner >> scanForTokenX9 [
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
]

{ #category : #generated }
MarvinScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace)
]

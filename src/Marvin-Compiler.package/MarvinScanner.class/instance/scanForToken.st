generated-scanner
scanForToken
	self step.
	(currentCharacter = $_ or: [ currentCharacter between: $a and: $z ])
		ifTrue: [ ^ self scan8 ].
	(currentCharacter between: $A and: $Z)
		ifTrue: [ 
			[ 
			self recordMatch: #(11 18).
			self step.
			(currentCharacter between: $0 and: $9) or: [ currentCharacter between: $A and: $Z ] ] whileTrue.
			(currentCharacter = $_ or: [ (currentCharacter between: $a and: $d) or: [ currentCharacter between: $f and: $z ] ])
				ifTrue: [ ^ self scan8 ].
			currentCharacter = $*
				ifTrue: [ ^ self recordAndReportMatch: #(12) ].
			currentCharacter = $.
				ifTrue: [ ^ self scan5 ].
			currentCharacter = $:
				ifTrue: [ ^ self scan9 ].
			currentCharacter = $e
				ifTrue: [ 
					self recordMatch: #(11).
					self step.
					((currentCharacter between: $A and: $Z) or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ])
						ifTrue: [ ^ self scan8 ].
					(currentCharacter between: $0 and: $9)
						ifTrue: [ 
							[ 
							self recordMatch: #(11 18).
							self step.
							((currentCharacter between: $A and: $Z)
								or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ])
								ifTrue: [ ^ self scan8 ].
							currentCharacter between: $0 and: $9 ] whileTrue.
							currentCharacter = $*
								ifTrue: [ ^ self recordAndReportMatch: #(12) ].
							currentCharacter = $:
								ifTrue: [ ^ self scan9 ].
							^ self reportLastMatch ].
					(currentCharacter = Character space
						or: [ currentCharacter = $+ or: [ currentCharacter = $- or: [ currentCharacter = $| ] ] ])
						ifTrue: [ ^ self scan7 ].
					currentCharacter = $*
						ifTrue: [ ^ self recordAndReportMatch: #(12) ].
					currentCharacter = $:
						ifTrue: [ ^ self scan9 ].
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	(currentCharacter = $!
		or: [ 
			(currentCharacter between: $% and: $&)
				or: [ 
					(currentCharacter between: $* and: $,)
						or: [ 
							currentCharacter = $/
								or: [ 
									(currentCharacter between: $; and: $<)
										or: [ (currentCharacter between: $> and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ] ])
		ifTrue: [ 
			[ 
			self recordMatch: #(16).
			self step.
			currentCharacter = $!
				or: [ 
					(currentCharacter between: $$ and: $&)
						or: [ 
							(currentCharacter between: $* and: $-)
								or: [ 
									currentCharacter = $/
										or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ] ]
				whileTrue.
			^ self reportLastMatch ].
	(currentCharacter between: $0 and: $9)
		ifTrue: [ ^ self scan3 ].
	((currentCharacter between: Character tab and: Character cr) or: [ currentCharacter = Character space ])
		ifTrue: [ 
			[ 
			self recordMatch: #whitespace.
			self step.
			(currentCharacter between: Character tab and: Character cr) or: [ currentCharacter = Character space ] ] whileTrue.
			^ self reportLastMatch ].
	currentCharacter = $"
		ifTrue: [ ^ self recordAndReportMatch: #comment ].
	currentCharacter = $#
		ifTrue: [ 
			self step.
			((currentCharacter between: $A and: $Z) or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ 
					[ 
					self recordMatch: #(22).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z) or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
						whileTrue.
					currentCharacter = $:
						ifTrue: [ ^ self scan1 ].
					^ self reportLastMatch ].
			(currentCharacter = $!
				or: [ 
					(currentCharacter between: $$ and: $&)
						or: [ 
							(currentCharacter between: $* and: $-)
								or: [ 
									currentCharacter = $/
										or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ])
				ifTrue: [ 
					[ 
					self recordMatch: #(22).
					self step.
					currentCharacter = $!
						or: [ 
							(currentCharacter between: $$ and: $&)
								or: [ 
									(currentCharacter between: $* and: $-)
										or: [ 
											currentCharacter = $/
												or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ] ]
						whileTrue.
					^ self reportLastMatch ].
			currentCharacter = $'
				ifTrue: [ ^ self scan2 ].
			currentCharacter = $(
				ifTrue: [ ^ self recordAndReportMatch: #(1) ].
			^ self reportLastMatch ].
	currentCharacter = $$
		ifTrue: [ 
			self recordMatch: #(16).
			self step.
			(currentCharacter <= Character space
				or: [ 
					(currentCharacter between: $" and: $#)
						or: [ 
							(currentCharacter between: $' and: $))
								or: [ 
									currentCharacter = $.
										or: [ 
											(currentCharacter between: $0 and: $:)
												or: [ (currentCharacter between: $A and: $[) or: [ (currentCharacter between: $] and: $}) or: [ currentCharacter >= $ ] ] ] ] ] ] ])
				ifTrue: [ ^ self recordAndReportMatch: #(17) ].
			(currentCharacter = $!
				or: [ 
					(currentCharacter between: $$ and: $&)
						or: [ 
							(currentCharacter between: $* and: $-)
								or: [ 
									currentCharacter = $/
										or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ])
				ifTrue: [ 
					self recordMatch: #(16 17).
					self step.
					(currentCharacter = $!
						or: [ 
							(currentCharacter between: $$ and: $&)
								or: [ 
									(currentCharacter between: $* and: $-)
										or: [ 
											currentCharacter = $/
												or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ])
						ifTrue: [ 
							[ 
							self recordMatch: #(16).
							self step.
							currentCharacter = $!
								or: [ 
									(currentCharacter between: $$ and: $&)
										or: [ 
											(currentCharacter between: $* and: $-)
												or: [ 
													currentCharacter = $/
														or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ] ]
								whileTrue.
							^ self reportLastMatch ].
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	currentCharacter = $'
		ifTrue: [ ^ self scan11 ].
	currentCharacter = $(
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter = $)
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter = $-
		ifTrue: [ 
			self recordMatch: #(16).
			self step.
			(currentCharacter between: $A and: $Z)
				ifTrue: [ ^ self scan4 ].
			(currentCharacter = $!
				or: [ 
					(currentCharacter between: $$ and: $&)
						or: [ 
							(currentCharacter between: $* and: $-)
								or: [ 
									currentCharacter = $/
										or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ])
				ifTrue: [ 
					[ 
					self recordMatch: #(16).
					self step.
					currentCharacter = $!
						or: [ 
							(currentCharacter between: $$ and: $&)
								or: [ 
									(currentCharacter between: $* and: $-)
										or: [ 
											currentCharacter = $/
												or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ] ]
						whileTrue.
					^ self reportLastMatch ].
			(currentCharacter between: $0 and: $9)
				ifTrue: [ ^ self scan3 ].
			^ self reportLastMatch ].
	currentCharacter = $.
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter = $:
		ifTrue: [ 
			self step.
			((currentCharacter between: $A and: $Z) or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ])
				ifTrue: [ 
					[ 
					self recordMatch: #(15).
					self step.
					(currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z) or: [ currentCharacter = $_ or: [ currentCharacter between: $a and: $z ] ] ] ]
						whileTrue.
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	currentCharacter = $=
		ifTrue: [ 
			self recordMatch: #(5 16).
			self step.
			(currentCharacter = $!
				or: [ 
					(currentCharacter between: $$ and: $&)
						or: [ 
							(currentCharacter between: $* and: $-)
								or: [ 
									currentCharacter = $/
										or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ])
				ifTrue: [ 
					[ 
					self recordMatch: #(16).
					self step.
					currentCharacter = $!
						or: [ 
							(currentCharacter between: $$ and: $&)
								or: [ 
									(currentCharacter between: $* and: $-)
										or: [ 
											currentCharacter = $/
												or: [ (currentCharacter between: $; and: $@) or: [ currentCharacter = $\ or: [ currentCharacter = $~ ] ] ] ] ] ] ]
						whileTrue.
					^ self reportLastMatch ].
			^ self reportLastMatch ].
	currentCharacter = $[
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter = $]
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter = $^
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter = $|
		ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	^ self reportLastMatch
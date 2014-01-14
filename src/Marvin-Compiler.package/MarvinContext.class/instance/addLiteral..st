as yet unclassified
addLiteral: object  

	| literal |

	object isConstantLiteral ifTrue: [ 
		literal := object content ].

	^ literals 
		indexOf: literal 
		ifAbsent: [literals add: literal. literals indexOf: literal].

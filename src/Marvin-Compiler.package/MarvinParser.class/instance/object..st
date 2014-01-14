generating
object: aCollection

	| object |
	
	object := MarvinObjectLiteral new.
	
	aCollection size = 3
		ifTrue: [
			object slots: aCollection second value.
			 ].

	^ object.
	


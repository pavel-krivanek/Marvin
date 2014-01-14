generating
binarySlot: aCollection

	| slot selector args |
	
	selector := aCollection first value.
	args := { aCollection second value }.
	
	slot := MarvinSlotLiteral new
			name: selector;
			type: #methodSlot.
	
	slot arguments: args.
			
	slot content: aCollection fourth value.
	slot content acceptArgumetsNamed: slot arguments.
	
	^ OrderedCollection with: slot.


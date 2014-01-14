generating
keywordSlot: aCollection

	| slot selector args |
	
	selector := aCollection first value first.
	args := aCollection first value second.

	slot := MarvinSlotLiteral new
			name: selector;	
			type: #methodSlot.
	
	slot arguments: args.
			
	slot content: aCollection third value.

	slot content acceptArgumetsNamed: args.
	
	^ OrderedCollection with: slot.


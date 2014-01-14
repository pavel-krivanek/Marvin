generating
unarySlot: aCollection

	| slot |
	
	slot := MarvinSlotLiteral new
			name: aCollection first value;
			type: #methodSlot.
			
	slot content: aCollection third.
	
	^ OrderedCollection with: slot.


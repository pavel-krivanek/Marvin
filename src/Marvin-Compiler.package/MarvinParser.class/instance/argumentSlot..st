generating
argumentSlot: aCollection

	| slot |
	
	slot := MarvinSlotLiteral new
			name: aCollection first value;	
			type: #argumentSlot.
	
	^ OrderedCollection with: slot.


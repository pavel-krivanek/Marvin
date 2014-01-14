as yet unclassified
acceptArgumetsNamed: names

	self slots addAll: (names collect: [ :argName |
		MarvinSlotLiteral new
				name: argName;	
				type: #argumentSlot ]).



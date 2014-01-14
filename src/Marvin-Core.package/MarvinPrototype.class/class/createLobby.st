as yet unclassified
createLobby
	
	" MarvinPrototype createLobby "

	| globals |

	lobby := MarvinPrototype new.

	globals := MarvinPrototype new.
	globals AddReadSlot: #lobby value: lobby.
	globals AddReadSlot: #nil value: nil.
	globals AddReadSlot: #true value: true.
	globals AddReadSlot: #false value: false.

	lobby AddParentSlot: #globals value: globals.

	lobby AddMethodSlot: #DoIt value: CompiledMethod toReturnSelf.
	lobby AddMethodSlot: #slotNotFound: value: (MarvinPrototype class >> #lobbyDNU:).
	lobby AddMethodSlot: #St: value: (MarvinPrototype class >> #SmalltalkObject:).

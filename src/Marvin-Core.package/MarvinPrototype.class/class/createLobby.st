as yet unclassified
createLobby
	
	" MarvinPrototype createLobby "

	| globals |

	lobby := MarvinPrototype new.

	globals := MarvinPrototype new.
	globals _AddReadSlot: #lobby value: lobby.
	globals _AddReadSlot: #nil value: nil.
	globals _AddReadSlot: #true value: true.
	globals _AddReadSlot: #false value: false.

	lobby _AddParentSlot: #globals value: globals.

	lobby _AddMethodSlot: #DoIt value: CompiledMethod toReturnSelf.
	lobby _AddMethodSlot: #slotNotFound: value: (MarvinPrototype class >> #lobbyDNU:).
	lobby _AddMethodSlot: #St: value: (MarvinPrototype class >> #SmalltalkObject:).

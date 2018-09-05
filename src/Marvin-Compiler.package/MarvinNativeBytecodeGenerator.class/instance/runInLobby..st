accessing
runInLobby: method

	| lobby |

	lobby := MarvinPrototype lobby.

	lobby _RemoveSlot: #DoIt.
	
	lobby _AddMethodSlot: #DoIt value: method.

	^ lobby DoIt




accessing
runInLobby: method

	| lobby |

	lobby := MarvinPrototype lobby.

	lobby RemoveSlot: #DoIt.
	
	lobby AddMethodSlot: #DoIt value: method.

	^ lobby DoIt




accessing
addSlotsValues

	contextLiteral slots do: [ :slot |
		slot isDataSlot ifTrue: [ 	
				| val |
				slot content 
					ifNotNil: [
						| gen method methodLiteral |
						slot content regenerate.
						gen := MarvinNativeBytecodeGenerator new.
						methodLiteral := MarvinMethodLiteral new.
						methodLiteral context: slot content.
						method := gen methodFrom: methodLiteral owner: MarvinPrototype lobby.
						val := gen runInLobby: method. 
	
						self parent literals add: val.
						slotsDictionary at: slot name put: val.
						].
			] ]
generating
parentSlot: aCollection 

	| slot slots |

	slots := OrderedCollection new.

	slot := (MarvinSlotLiteral new)
				name: aCollection first value.

	aCollection size = 3 
		ifTrue: [
			| cont |.
			slot type: ((aCollection second value = '=')
				ifTrue:  [ #parentSlot ]
				ifFalse: [ #readWriteParentSlot ]).
			cont := aCollection third.
			cont addInstruction: (cont generator instrReturnTop ).
			slot content: cont.
		]
		ifFalse: [slot content: nil].
		
	slots add: slot copy.
	
	^slots.

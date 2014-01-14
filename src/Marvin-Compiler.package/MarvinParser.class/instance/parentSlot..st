generating
parentSlot: aCollection 

	| slot slots |

	slots := OrderedCollection new.

	slot := (MarvinSlotLiteral new)
				name: aCollection first value.

	aCollection size = 5 
		ifTrue: [
			| cont |.
			slot type: ((aCollection second value = '=')
				ifTrue:  [ #parentSlot ]
				ifFalse: [ #readWriteParentSlot ]).
			cont := aCollection fourth.
			cont addInstruction: (cont generator instrReturnTop ).
			slot content: cont.
		]
		ifFalse: [slot content: nil].
		
	slots add: slot copy.
	
	^slots.

generating
dataSlot: aCollection 

	| slot slots |

	slots := OrderedCollection new.

	" read slot "
	slot := (MarvinSlotLiteral new)
				name: aCollection first value;
				type: #assignSlot.
	aCollection size = 5 
		ifTrue: [
			| cont |.
			slot type: ((aCollection second value = '=')
				ifTrue:  [ #readSlot ]
				ifFalse: [ #assignSlot ]).
			cont := aCollection fourth.
			cont addInstruction: (cont generator instrReturnTop ).
			slot content: cont.
		]
		ifFalse: [slot content: nil].
		
	slots add: slot copy.
	
	^slots 
		

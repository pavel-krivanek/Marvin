objects
createObjectFrom: literal

	| object |

	object := MarvinPrototype new.	

	literal slots do: [ :slot |
		slot type = #readSlot
			ifTrue: [ 	
				| val |
				slot content 
					ifNotNil: [
						| gen method methodLiteral |
						slot content regenerate.
						gen := MarvinNativeBytecodeGenerator new.
						methodLiteral := MarvinMethodLiteral new.
						methodLiteral context: slot content.
						method := gen methodFrom: methodLiteral owner: object.
						val := gen runInLobby: method. ].
				object _AddReadSlot: slot name asSymbol value:  val.
			].

		slot type = #assignSlot
			ifTrue: [ 	
				| val |
				slot content 
					ifNotNil: [
						| gen method methodLiteral |
						slot content regenerate.
						gen := MarvinNativeBytecodeGenerator new.
						methodLiteral := MarvinMethodLiteral new.
						methodLiteral context: slot content.
						method := gen methodFrom: methodLiteral owner: object.
						val := gen runInLobby: method. ].
				object _AddAssignSlot: slot name asSymbol value:  val.
			].

		slot type = #methodSlot
			ifTrue: [ 	
				| method |
				slot content
					ifNotNil: [
						| methodLiteral |
						methodLiteral := slot content.
						method := MarvinNativeBytecodeGenerator new methodFrom: methodLiteral owner: object. ].
				object _AddMethodSlot: slot name asSymbol value:  method.
			].
		((slot type = #parentSlot) | (slot type = #readWriteParentSlot))
			ifTrue: [ 	
				| val |
				slot content 
					ifNotNil: [
						| gen method methodLiteral |
						slot content regenerate.
						gen := MarvinNativeBytecodeGenerator new.
						gen returnSelf: false.
						methodLiteral := MarvinMethodLiteral new.
						methodLiteral context: slot content.
						method := gen methodFrom: methodLiteral owner: object..
						val := gen runInLobby: method. ].
				slot type = #parentSlot
					ifTrue: [ object _AddParentSlot: slot name allButLast asSymbol value:  val]
					ifFalse: [ object _AddReadWriteParentSlot: slot name allButLast asSymbol value:  val ].
			]
	 ].

	"{ literal. object } explore."

	^ object.
	
	
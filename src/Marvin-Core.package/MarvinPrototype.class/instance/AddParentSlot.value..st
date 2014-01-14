slots
AddParentSlot: slotName value: obj

	| newPrototype a b |

	slotName ifNil: [ self error: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype new: self size + 3.
	
	a := 1.
	b := 1.

	" parent slots "
	[(self at: a) = nil ]
		whileFalse: [
			newPrototype at: b put: (self at: a).
			newPrototype at: b+1 put: (self at: a+1).
			newPrototype at: b+2 put: (self at: a+2).
			a := a+3. 
			b := b+3.].
	
	" add slot "

	newPrototype at: b put: slotName.
	newPrototype at: b+1 put: slotName.
	newPrototype at: b+2 put: obj.

	b := b + 3.

	[ a <= self size ]
		whileTrue: [
			newPrototype at: b put: (self at: a).
			a := a+1. 
			b := b +1.].

	self become: newPrototype.
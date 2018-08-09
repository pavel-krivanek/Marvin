slots
AddMethodSlot: slotName value: method

	| newPrototype a b |

	slotName ifNil: [ self error: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype basicNew: self primitiveSize + 2.
	
	a := self primitiveSize.
	b := newPrototype primitiveSize.

	" parent slots "
	[(self at: a) = nil ]
		whileFalse: [
			newPrototype at: b put: (self at: a).
			newPrototype at: b-1 put: (self at: a-1).
			newPrototype at: b-2 put: (self at: a-2).
			a := a - 3.
			b := b - 3 ].

	a := a - 1.
	b := b - 1.
	
	" method slots "
	[(self at: a) = nil ]
		whileFalse: [
			newPrototype at: b put: (self at: a).
			newPrototype at: b-1 put: (self at: a-1).
			a := a - 2. 
			b := b - 2.].


	" add slot "

	newPrototype at: b put: slotName.
	newPrototype at: b-1 put: method.
	b := b - 2.

	"rest "	

	[ a > 0 ] whileTrue: [
			newPrototype at: b put: (self at: a).
			a := a - 1. 
			b := b - 1.].

	self become: newPrototype.

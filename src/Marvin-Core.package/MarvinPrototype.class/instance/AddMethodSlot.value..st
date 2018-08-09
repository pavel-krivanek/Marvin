slots
AddMethodSlot: slotName value: method

	| newPrototype a b |

	slotName ifNil: [ self error: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype basicNew: self PrimitiveSize + 2.
	
	a := self PrimitiveSize.
	b := newPrototype PrimitiveSize.

	" parent slots "
	[(self PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype PrimitiveAt: b put: (self PrimitiveAt: a).
			newPrototype PrimitiveAt: b-1 put: (self PrimitiveAt: a-1).
			newPrototype PrimitiveAt: b-2 put: (self PrimitiveAt: a-2).
			a := a - 3.
			b := b - 3 ].

	a := a - 1.
	b := b - 1.
	
	" method slots "
	[(self PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype PrimitiveAt: b put: (self PrimitiveAt: a).
			newPrototype PrimitiveAt: b-1 put: (self PrimitiveAt: a-1).
			a := a - 2. 
			b := b - 2.].


	" add slot "

	newPrototype PrimitiveAt: b put: slotName.
	newPrototype PrimitiveAt: b-1 put: method.
	b := b - 2.

	"rest "	

	[ a > 0 ] whileTrue: [
			newPrototype PrimitiveAt: b put: (self PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	self become: newPrototype.

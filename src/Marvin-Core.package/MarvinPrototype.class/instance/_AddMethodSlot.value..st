slots
_AddMethodSlot: slotName value: method

	| newPrototype a b |

	slotName ifNil: [ self error: 'Wrong slot name' ].
	
	newPrototype := MarvinPrototype basicNew: self _PrimitiveSize + 2.
	
	a := self _PrimitiveSize.
	b := newPrototype _PrimitiveSize.

	" parent slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
			a := a - 3.
			b := b - 3 ].

	a := a - 1.
	b := b - 1.
	
	" method slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
			a := a - 2. 
			b := b - 2.].


	" add slot "

	newPrototype _PrimitiveAt: b put: slotName.
	newPrototype _PrimitiveAt: b-1 put: method.
	b := b - 2.

	"rest "	

	[ a > 0 ] whileTrue: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	self become: newPrototype.

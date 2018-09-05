slots
_RemoveSlot: slotName 

	| newPrototype a b found |

	a := self _PrimitiveSize.
	b := self _PrimitiveSize.
	found := false.
		
	newPrototype := Array basicNew: self _PrimitiveSize.

	" parent slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			((self _PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 3. ]
				ifFalse: [ 
					newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
					newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
					newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
					a := a - 3. 
					b := b - 3.] ].

	a := a - 1.
	newPrototype _PrimitiveAt: b put: nil.
	b := b - 1.
	
	" message slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			((self _PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 2. ]
				ifFalse: [ 
					newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
					newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
					a := a - 2. 
					b := b - 2.] ].
	
	a := a - 1.
	newPrototype _PrimitiveAt: b put: nil.
	b := b - 1.

	" data slots "
	[(self _PrimitiveAt: a) = nil ]
		whileFalse: [
			((self _PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 3. ]
				ifFalse: [ 
					newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
					newPrototype _PrimitiveAt: b-1 put: (self _PrimitiveAt: a-1).
					newPrototype _PrimitiveAt: b-2 put: (self _PrimitiveAt: a-2).
					a := a - 3. 
					b := b - 3.] ].

	[ a > 0 ] whileTrue: [
			newPrototype _PrimitiveAt: b put: (self _PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	found ifFalse: [ MarvinSlotNotFound signal ].

	self become: (MarvinPrototype withAll: (newPrototype copyFrom: b-a+1 to: self _PrimitiveSize)).


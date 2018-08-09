slots
RemoveSlot: slotName 

	| newPrototype a b found |

	a := self PrimitiveSize.
	b := self PrimitiveSize.
	found := false.
		
	newPrototype := Array basicNew: self PrimitiveSize.

	" parent slots "
	[(self PrimitiveAt: a) = nil ]
		whileFalse: [
			((self PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 3. ]
				ifFalse: [ 
					newPrototype PrimitiveAt: b put: (self PrimitiveAt: a).
					newPrototype PrimitiveAt: b-1 put: (self PrimitiveAt: a-1).
					newPrototype PrimitiveAt: b-2 put: (self PrimitiveAt: a-2).
					a := a - 3. 
					b := b - 3.] ].

	a := a - 1.
	newPrototype PrimitiveAt: b put: nil.
	b := b - 1.
	
	" message slots "
	[(self PrimitiveAt: a) = nil ]
		whileFalse: [
			((self PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 2. ]
				ifFalse: [ 
					newPrototype PrimitiveAt: b put: (self PrimitiveAt: a).
					newPrototype PrimitiveAt: b-1 put: (self PrimitiveAt: a-1).
					a := a - 2. 
					b := b - 2.] ].
	
	a := a - 1.
	newPrototype PrimitiveAt: b put: nil.
	b := b - 1.

	" data slots "
	[(self PrimitiveAt: a) = nil ]
		whileFalse: [
			((self PrimitiveAt: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 3. ]
				ifFalse: [ 
					newPrototype PrimitiveAt: b put: (self PrimitiveAt: a).
					newPrototype PrimitiveAt: b-1 put: (self PrimitiveAt: a-1).
					newPrototype PrimitiveAt: b-2 put: (self PrimitiveAt: a-2).
					a := a - 3. 
					b := b - 3.] ].

	[ a > 0 ] whileTrue: [
			newPrototype PrimitiveAt: b put: (self PrimitiveAt: a).
			a := a - 1. 
			b := b - 1.].

	found ifFalse: [ MarvinSlotNotFound signal ].

	self become: (MarvinPrototype withAll: (newPrototype copyFrom: b-a+1 to: self PrimitiveSize)).


slots
RemoveSlot: slotName 

	| newPrototype a b found reduction |

	a := self primitiveSize.
	b := self primitiveSize.
	reduction := 0.
	found := false.

	newPrototype := Array new: self primitiveSize.

	" parent slots "
	[(self at: a) = nil ]
		whileFalse: [
			((self at: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 3.
					reduction := reduction + 3 ]
				ifFalse: [ 
					newPrototype at: b put: (self at: a).
					newPrototype at: b-1 put: (self at: a-1).
					newPrototype at: b-2 put: (self at: a-2).
					a := a - 3. 
					b := b - 3.] ].

	a := a - 1.
	newPrototype at: b put: nil.
	b := b - 1.
	
	" message slots "
	[(self at: a) = nil ]
		whileFalse: [
			((self at: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 2.
					reduction := reduction + 2 ]
				ifFalse: [ 
					newPrototype at: b put: (self at: a).
					newPrototype at: b-1 put: (self at: a-1).
					a := a - 2. 
					b := b - 2.] ].
	
	a := a - 1.
	newPrototype at: b put: nil.
	b := b - 1.

	" data slots "
	[(self at: a) = nil ]
		whileFalse: [
			((self at: a) == slotName)
				ifTrue: [ 
					found := true.
					a := a - 3.
					reduction := reduction + 3 ]
				ifFalse: [ 
					newPrototype at: b put: (self at: a).
					newPrototype at: b-1 put: (self at: a-1).
					newPrototype at: b-2 put: (self at: a-2).
					a := a - 3. 
					b := b - 3.] ].

	found ifFalse: [ MarvinSlotNotFound signal ].

	self become: (MarvinPrototype withAll: (newPrototype copyFrom: reduction to: self primitiveSize)).


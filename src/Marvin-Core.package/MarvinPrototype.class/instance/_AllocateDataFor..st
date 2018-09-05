data
_AllocateDataFor: aBehavior

	| newObject instSize |
	
	instSize := aBehavior instSize.

	newObject := MarvinPrototype basicNew: self _PrimitiveSize + instSize.
	
	1 to: self _PrimitiveSize do: [ :index | newObject _PrimitiveAt: instSize + index put: (self _PrimitiveAt: index) ].

	self become: newObject.

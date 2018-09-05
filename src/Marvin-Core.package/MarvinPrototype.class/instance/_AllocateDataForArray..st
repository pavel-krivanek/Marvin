data
_AllocateDataForArray: anArray

	| newObject instSize |
	
	instSize := anArray size.

	newObject := MarvinPrototype basicNew: self _PrimitiveSize + instSize.
	
	1 to: self _PrimitiveSize do: [ :index | newObject _PrimitiveAt: instSize + index put: (self _PrimitiveAt: index) ].

	self become: newObject.

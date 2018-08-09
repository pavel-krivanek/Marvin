data
AllocateDataForArray: anArray

	| newObject instSize |
	
	instSize := anArray size.

	newObject := MarvinPrototype basicNew: self PrimitiveSize + instSize.
	
	1 to: self PrimitiveSize do: [ :index | newObject PrimitiveAt: instSize + index put: (self PrimitiveAt: index) ].

	self become: newObject.

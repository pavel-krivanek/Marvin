data
AllocateDataFor: aBehavior

	| newObject instSize |
	
	instSize := aBehavior instSize.

	newObject := MarvinPrototype basicNew: self PrimitiveSize + instSize.
	
	1 to: self PrimitiveSize do: [ :index | newObject PrimitiveAt: instSize + index put: (self PrimitiveAt: index) ].

	self become: newObject.

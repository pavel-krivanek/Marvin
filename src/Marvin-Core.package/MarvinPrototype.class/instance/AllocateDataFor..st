slots
AllocateDataFor: aBehavior

	| newObject instSize |
	
	instSize := aBehavior instSize.

	newObject := MarvinPrototype basicNew: self primitiveSize + instSize.
	
	1 to: self primitiveSize do: [ :index | newObject at: instSize + index put: (self at: index) ].

	self become: newObject.

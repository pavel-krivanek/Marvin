slots
AllocateDataFor: aBehavior

	| newObject instSize |
	
	instSize := aBehavior instSize.

	newObject := MarvinPrototype basicNew: self primitiveSize + instSize.
	
	1 to: self primitiveSize do: [ :index | newObject instVarAt: instSize + index put: (self instVarAt: index) ].

	self become: newObject.

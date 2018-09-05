data
_FillFromArray: anObject
	
	1 to: anObject size do: [ :index |
		self _PrimitiveAt: index put: (anObject _PrimitiveAt: index )].


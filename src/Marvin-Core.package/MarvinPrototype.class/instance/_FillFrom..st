data
_FillFrom: anObject
	
	1 to: anObject class instSize do: [ :index |
		self _PrimitiveAt: index put: (anObject _PrimitiveAt: index )].


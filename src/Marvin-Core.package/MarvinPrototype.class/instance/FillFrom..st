slots
FillFrom: anObject
	
	1 to: anObject class instSize do: [ :index |
		self PrimitiveAt: index put: (anObject PrimitiveAt: index )].


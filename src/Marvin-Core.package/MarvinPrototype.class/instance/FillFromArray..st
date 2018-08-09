data
FillFromArray: anObject
	
	1 to: anObject size do: [ :index |
		self PrimitiveAt: index put: (anObject PrimitiveAt: index )].


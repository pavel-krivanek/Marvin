slots
FillFrom: anObject
	
	1 to: anObject class instSize do: [ :index |
		self instVarAt: index put: (anObject instVarAt: index )].


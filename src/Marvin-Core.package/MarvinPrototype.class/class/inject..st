as yet unclassified
inject: anObject

	| newObject |
	
	newObject := MarvinPrototype new.
	^ newObject _Inject: anObject
	
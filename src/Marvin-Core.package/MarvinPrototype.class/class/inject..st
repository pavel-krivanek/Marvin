as yet unclassified
inject: anObject

	| newObject |
	
	newObject := MarvinPrototype new.
	^ newObject Inject: anObject
	
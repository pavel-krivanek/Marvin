as yet unclassified
injectArray: anObject

	| newObject |
	
	newObject := MarvinPrototype new.
	^ newObject _InjectArray: anObject
	
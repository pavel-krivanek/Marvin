as yet unclassified
inject: anObject

	| newObject |
	
	newObject := MarvinPrototype new.
	newObject AddInheritance: #class from: anObject class.
	newObject FillFrom: anObject.
	
	newObject become: anObject.
	^ anObject.
	
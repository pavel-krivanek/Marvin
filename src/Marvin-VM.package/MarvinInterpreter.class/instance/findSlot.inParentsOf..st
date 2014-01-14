as yet unclassified
findSlot: msgSelector inParentsOf: obj

	| index currentSlot currentParent found |

	self inline: false.
	
	index := 0.

	[ currentSlot := self fetchPointer: index ofObject: obj.
	currentSlot = self nilObject. ]
		whileFalse: [
			currentParent := (self fetchPointer: index+2 ofObject: obj).
			((self fetchClassOf: currentParent)  = (objectMemory splObj: ClassPrototype))
				ifTrue: [	 
					found := self findSlot: msgSelector in: currentParent.
					found = self nilObject ifFalse: [ ^ found ]].
			index := index + 3 ].

	^ self nilObject.

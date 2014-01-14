as yet unclassified
findSlot: msgSelector in: obj

	| index currentSlot currentParent found objClass |

	self inline: false.

	objClass := objectMemory fetchClassOf:  obj.

	1 to: sackPosition do: [ :pos | 
		(sack at: pos) = obj ifTrue: [ ^ objectMemory nilObject ] ].	

	objClass = (objectMemory splObj: ClassPrototype) 
		ifFalse: [
			lkupClass := objClass.
			"self internalFindNewMethod."
			(self messageImplementedByClass: objClass )
				ifTrue: [ ^ obj]
				ifFalse: [
					sackPosition := sackPosition +1.
					sackPosition > SackSize ifTrue: [ self error: 'prototypes buffer overflow' ].
					sack at: sackPosition put: obj. 
					^ objectMemory nilObject. ] ].

	index := 0.
	
	" process parent slots as messgaes "

	[ currentSlot := objectMemory fetchPointer: index ofObject: obj.
	currentSlot = objectMemory nilObject. ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) ifTrue: [ ^ obj ].
 			" write message "
			currentSlot := objectMemory fetchPointer: index+1 ofObject: obj.			
			(currentSlot = messageSelector) ifTrue: [ ^ obj ].

			index := index + 3 ].

	index := index + 1.

	" process method slots "

	[ currentSlot := objectMemory fetchPointer: index ofObject: obj.
	currentSlot = objectMemory nilObject. ]
		whileFalse: [	 
			(currentSlot = messageSelector) ifTrue: [ ^ obj ]. 
			index := index + 2 ].
		
	index := index + 1.

	" process data slots "

	[ currentSlot := objectMemory fetchPointer: index ofObject: obj.
	currentSlot = objectMemory nilObject. ]
		whileFalse: [ 
			" read message "
			(currentSlot = messageSelector) ifTrue: [ ^ obj ].
 			" write message "
			currentSlot := self fetchPointer: index+1 ofObject: obj.			
			(currentSlot = messageSelector) 
				ifTrue: [ ^ obj ].

			index := index + 3 ].

	" add to sack "
	
	sackPosition := sackPosition +1.
	sackPosition > SackSize ifTrue: [ self error: 'prototypes buffer overflow' ].
	sack at: sackPosition put: obj.

	" find in parents "

	index := 0.

	[ currentSlot := objectMemory fetchPointer: index ofObject: obj.
	currentSlot = objectMemory nilObject. ]
		whileFalse: [
			currentParent := (objectMemory fetchPointer: index+2 ofObject: obj).
			found := self findSlot: msgSelector in: currentParent.
			found = objectMemory nilObject ifFalse: [ ^ found ].
			index := index + 3].

	^ objectMemory nilObject.

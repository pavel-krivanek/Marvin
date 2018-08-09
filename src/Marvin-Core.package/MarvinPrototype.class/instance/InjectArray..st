data
InjectArray: anObject

	self AddParentSlot: #class value: anObject class.
	self AllocateDataForArray: anObject.
	self FillFromArray: anObject.
	
	anObject becomeForward: self.
	^ self.
	
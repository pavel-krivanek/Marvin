data
_InjectArray: anObject

	self _AddParentSlot: #class value: anObject class.
	self _AllocateDataForArray: anObject.
	self _FillFromArray: anObject.
	
	anObject becomeForward: self.
	^ self.
	
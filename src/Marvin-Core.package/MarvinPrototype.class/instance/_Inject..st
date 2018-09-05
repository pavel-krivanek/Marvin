data
_Inject: anObject

	self _AddInheritance: #class from: anObject class.
	self _FillFrom: anObject.
	
	anObject becomeForward: self.
	^ self.
	
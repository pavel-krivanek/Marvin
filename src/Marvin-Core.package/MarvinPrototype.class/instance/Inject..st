data
Inject: anObject

	self AddInheritance: #class from: anObject class.
	self FillFrom: anObject.
	
	anObject becomeForward: self.
	^ self.
	
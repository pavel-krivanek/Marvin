data
RevertInjection

	| aClass replacement |
	
	aClass := self class.
	replacement := aClass basicNew.
	1 to: aClass instSize do: [ :index |
		replacement PrimitiveAt: index put: (self PrimitiveAt: index )].
		
	"replacement becomeForward: self."
	self becomeForward: replacement.
	^ self.
	
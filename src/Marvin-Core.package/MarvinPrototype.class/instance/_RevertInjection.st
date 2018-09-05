data
_RevertInjection

	| aClass replacement |
	
	aClass := self class.
	replacement := aClass basicNew.
	1 to: aClass instSize do: [ :index |
		replacement _PrimitiveAt: index put: (self _PrimitiveAt: index )].
		
	"replacement becomeForward: self."
	self becomeForward: replacement.
	^ self.
	
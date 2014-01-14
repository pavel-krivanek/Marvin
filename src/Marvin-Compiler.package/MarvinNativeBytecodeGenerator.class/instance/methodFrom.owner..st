accessing
methodFrom: aContext owner: aPrototype

	| method |
	
	contextLiteral := aContext.
	
	self literals: aContext context selectors copy.
	self literals addAll: aContext context literals.
	
	self generateCode.
	
	method := self compiledMethodForOwner: aPrototype.
	
	Transcript show: method symbolic; cr; cr.

	^ method.




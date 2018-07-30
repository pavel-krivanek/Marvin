*Marvin-Core
performMessage: aMessage inContextOf: anObject

	| aCompiledMethod |
	
	aCompiledMethod := self compiledMethodAt: aMessage selector ifAbsent: [ ^ MarvinPrototype DNU ].
	
	^ aCompiledMethod valueWithReceiver: anObject arguments: aMessage arguments. 
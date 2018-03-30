tests
testEmpty

	| object |
	
	object := MarvinPrototype new.
	self should: [ object data ] raise: MarvinSlotNotFound. 
	
accessing
initialize

	super initialize.
	
	arguments := OrderedCollection new.
	temporaries := OrderedCollection new.
	literals := OrderedCollection new.
	bytecodes := OrderedCollection new.
	slotsDictionary := Dictionary new.
	returnSelf := true.

initialize-release
initialize

	super initialize.
	
	contexts := OrderedCollection new.
	contexts add: MarvinContext new.
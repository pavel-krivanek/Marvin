as yet unclassified
initialize

	super initialize.

	expandedForm := self iconNamed: #arrowDown.
	collapsedForm := self iconNamed: #forward.

	self extent: 16@16..
	self collapse.
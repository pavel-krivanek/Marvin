as yet unclassified
initialize

	super initialize.

	expandedForm := SimpleHierarchicalListMorph expandedForm.
	collapsedForm := SimpleHierarchicalListMorph notExpandedForm.

	self extent: 16@16..
	self collapse.
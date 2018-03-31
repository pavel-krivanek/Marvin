as yet unclassified
collapse
	state := #collapsed.
	toggleAction ifNotNil: [toggleAction value: state].
	self changed
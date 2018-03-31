as yet unclassified
expand
	state := #expanded.
	toggleAction ifNotNil: [toggleAction value: state].
	self changed
as yet unclassified
addTitle

	self title: (MarvinOtlExpandingTitleMorph  new
		toggleAction: self toggleAction).

	self addMorph: self title.
	
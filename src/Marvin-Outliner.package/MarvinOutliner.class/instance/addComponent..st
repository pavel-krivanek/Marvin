as yet unclassified
addComponent: anOutlinerComponent

	self addMorph: anOutlinerComponent.
	anOutlinerComponent outliner: self.
	self adjustWidth.

	
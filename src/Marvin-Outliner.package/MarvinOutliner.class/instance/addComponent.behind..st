as yet unclassified
addComponent: anOutlinerComponent behind: anComponent

	self addMorph: anOutlinerComponent behind: anComponent.
	anOutlinerComponent outliner: self.
	self adjustWidth.

	
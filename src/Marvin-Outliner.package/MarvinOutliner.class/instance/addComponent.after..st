as yet unclassified
addComponent: anOutlinerComponent after: anComponent

	self addMorph: anOutlinerComponent after: anComponent.
	anOutlinerComponent outliner: self.
	self adjustWidth.

	
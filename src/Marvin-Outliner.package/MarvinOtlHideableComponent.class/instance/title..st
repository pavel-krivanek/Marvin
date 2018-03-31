as yet unclassified
title: aTitleMorph
self halt.
	title := aTitleMorph.

	aTitleMorph outlinerComponent: self.
	title hResizing: #rigid.
	
	self addMorph: aTitleMorph after: container.

	
as yet unclassified
title: aTitleMorph
self halt.
	titleMorph := aTitleMorph.

	aTitleMorph outlinerComponent: self.
	titleMorph hResizing: #rigid.
	
	self addMorph: aTitleMorph after: container.

	
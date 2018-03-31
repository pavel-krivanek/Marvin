as yet unclassified
initialize

	resizingMorph := MarvinOtlEditorResizingMorph new.

	super initialize.

	self addMorph: resizingMorph.	

	self extent: 320 @ 120.
	self color: Color white.

	resizingMorph position: (self position x + super width)@(self position y + super height).

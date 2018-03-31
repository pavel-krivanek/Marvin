as yet unclassified
initializeFor: aModel

	self extent: 320 @ 120.
	self color: Color white.

	resizingMorph := MarvinOtlEditorResizingMorph new.
	resizingMorph position: (self position x + super width) 
				@ (self position y + super height).



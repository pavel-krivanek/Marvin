as yet unclassified
initialize

	super initialize.

	self color: (Color r: 0.835 g: 0.835 b: 0.771)..
	self borderWidth: 0.
	self layoutPolicy: ProportionalLayout new.
	self listDirection: #leftToRight.
	self cellInset: 5.
	self hResizing: #spaceFill.
	self vResizing: #none..

	labelMorph := MarvinOtlLabelMorph new.
	labelMorph hResizing: #spaceFill.
	self addMorph: labelMorph
		fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 1@1) 
				offsets: (12@0 corner: -16@0)).

	buttonMorph := MarvinOtlDragButton new.

	self addMorph: buttonMorph
			fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 0@0) 
				offsets: (0@0 corner: 8@16)).

	referenceButton := MarvinOtlReferenceButton new.

	self addMorph: referenceButton copy
			fullFrame: (
			LayoutFrame 
				fractions: (1@1 corner: 1@1) 
				offsets: ((-16)@(-16) corner: 0@0)).

	self height: (labelMorph height max: buttonMorph height).

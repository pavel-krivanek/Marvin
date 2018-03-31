as yet unclassified
initialize

	super initialize.

	self color: (Color transparent)..
	self borderWidth: 0.
	self layoutPolicy: ProportionalLayout new.
	self listDirection: #leftToRight.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

"	labelMorph := StringMorph new.
	self addMorph: labelMorph
		fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 1@1) 
				offsets: (19@0 corner: -16@0)).
"
"	buttonMorph := MarvinOtlDragMorph new.

	self addMorph: buttonMorph
			fullFrame: (
			LayoutFrame 
				fractions: (0@0 corner: 0@0) 
				offsets: (0@0 corner: 16@16)).

	self addMorph: buttonMorph copy
			fullFrame: (
			LayoutFrame 
				fractions: (1@1 corner: 1@1) 
				offsets: ((-16)@(-16) corner: 0@0)).

	self height: (labelMorph height max: buttonMorph height).
"
	self height: 8.
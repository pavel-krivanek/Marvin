as yet unclassified
initialize

	super initialize.

	self color: Color transparent.
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self reverseTableCells: true.
	self cellPositioning: #leftCenter.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

	self addTitle.

	state := #collapsed.

	self enableDrag: false.
	
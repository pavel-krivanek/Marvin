as yet unclassified
initialize

	super initialize.

	state := #collapsed.

	self addTitle.


	self color: Color red.
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self reverseTableCells: true.
	self cellPositioning: #leftCenter.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.



	self enableDrag: false.
	
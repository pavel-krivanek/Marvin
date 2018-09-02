as yet unclassified
initialize

	super initialize.

	self color: Color red.
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self cellPositioning: #leftCenter.
	self reverseTableCells: true.
	self layoutInset: 5.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

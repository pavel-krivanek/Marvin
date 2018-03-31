as yet unclassified
initialize

	super initialize.

	self layoutPolicy: TableLayout new.
	self listDirection: #topToBottom.
	self hResizing: #shrinkWrap; vResizing: #shrinkWrap.
	self layoutInset: 4; cellInset: 2.
	self cellPositioning: #topLeft.
	self color:  (Color r: 0.935 g: 0.935 b: 0.871).
	self minCellSize: 100@10.

	self borderWidth: 2.
	self borderColor: #raised.

	self reverseTableCells: true.

	self addMorph: (MarvinOtlHeader new).

	



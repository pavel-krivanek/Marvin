as yet unclassified
initialize

	super initialize.

	"self color: Color transparent."
	self borderWidth: 0.
	self layoutPolicy: TableLayout new.
	self reverseTableCells: true.
	self cellPositioning: #leftCenter.
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.

	self enableDrag: false.

	container := MarvinOtlContainer new.
	self addMorph: container.

	self toggle:#collapsed.

	
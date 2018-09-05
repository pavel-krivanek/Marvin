private
withAll: obj

	| n |
	n := super new: obj size.
	1 to: obj size do: [ :i | n _PrimitiveAt: i put: (obj at: i) ].
	^ n.

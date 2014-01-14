private
withAll: obj

	| n |
	n := self new: obj size.
	1 to: obj size do: [ :i | n at: i put: (obj at: i) ].
	^ n.

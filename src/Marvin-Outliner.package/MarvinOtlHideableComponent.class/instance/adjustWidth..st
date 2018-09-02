as yet unclassified
adjustWidth: minimalWidth

	| maxWidth |

	maxWidth := minimalWidth max: self optimalWidth.

	super adjustWidth: maxWidth.

	self title ifNotNil: [
		self title width: maxWidth. ]
	



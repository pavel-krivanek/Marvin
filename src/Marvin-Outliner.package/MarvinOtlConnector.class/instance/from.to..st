access
from: aConnectionEnd to: anotherConnectionEnd 
	super initialize.
	self makeOpen.
	"self makeForwardArrow."
	"set my connectionEnds"
	self anchors: (Array with: aConnectionEnd with: anotherConnectionEnd) asOrderedCollection.
	handler holder: anotherConnectionEnd.

	self borderColor: Color black.
	self borderWidth: 1.
	self openInWorld
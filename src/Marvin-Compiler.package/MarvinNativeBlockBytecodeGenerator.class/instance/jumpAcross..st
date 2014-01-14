as yet unclassified
jumpAcross: aBlock


	"longUnconditionalJump"

	| position toPosition |

	position := self parent bytecodes size.
	self parent bytecodes add: nil.
	self parent bytecodes add: nil.

	aBlock value.
	
	toPosition := self parent bytecodes size.

	self parent bytecodes at: (position+1) put: 164 + ((toPosition-position-2) // 256).
	self parent bytecodes at: (position+2) put: (toPosition-position-2) \\ 256

"	self parent bytecodes at: (position+1) put: 164.
	self parent bytecodes at: (position+2) put: 0.
"
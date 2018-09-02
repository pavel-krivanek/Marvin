as yet unclassified
adjustWidth

	| own |

	own := self owner.

	own ifNil: [ ^ self ].
	(own isKindOf: PasteUpMorph) ifTrue: [ ^ self ].

	 own adjustWidth.
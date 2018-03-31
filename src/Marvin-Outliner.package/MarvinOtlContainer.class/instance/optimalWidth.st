as yet unclassified
optimalWidth

	| elements |

	elements := self submorphs.
	elements ifEmpty: [ ^ 0 ].

	^ (elements collect: [ :m | m width]) max
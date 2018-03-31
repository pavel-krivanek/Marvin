as yet unclassified
newValueMorph

	| morph |

	morph := StringMorph new.
	morph vResizing: #none.
	morph hResizing: #shrinkWrap.
	morph minWidth: 50.

	morph contents: 'val '.

	^ morph

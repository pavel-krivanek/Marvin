as yet unclassified
newValueMorph

	| morph |

	morph := StringMorph new.
	morph vResizing: #shrinkWrap.
	morph hResizing: #rigid.
	morph minWidth: 50.

	morph contents: 'val '.

	^ morph

as yet unclassified
newNameMorph

	| morph |

	morph := StringMorph new.
	morph vResizing: #none.
	morph hResizing: #spaceFill.

	morph contents: 'name'.

	morph minWidth: 200.


	^ morph

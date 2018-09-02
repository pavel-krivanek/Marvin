as yet unclassified
toggle: aSymbol 
	"Some obsolete code in this method, it would require an optimalization!"
	
	aSymbol 
		ifNil: [ 
			state := state = #collapsed
				ifTrue: [ #expanded ]
				ifFalse: [ #collapsed ] ]
		ifNotNil: [ state := aSymbol.].


	state = #collapsed 
		ifTrue: 
			[ titleMorph hResizing: #rigid.
			self hideableSubmorphs do: [ :m | m hide].
			self layoutChanged.
			self adjustWidth: titleMorph minWidth.
			self adjustWidth ]
		ifFalse: 
			[ self submorphs do: [:sm | sm = titleMorph ifFalse: [sm show]].
			self layoutChanged.
			titleMorph hResizing: #rigid.
			titleMorph layoutChanged.
			self adjustWidth: self optimalWidth .
			self adjustWidth.].

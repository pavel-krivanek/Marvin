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
			[ self title hResizing: #rigid.
			self hideableSubmorphs do: [ :m | m hide].
			self layoutChanged.
			self adjustWidth: self title minWidth.
			self adjustWidth ]
		ifFalse: 
			[ self submorphs do: [:sm | sm = self title ifFalse: [sm show]].
			self layoutChanged.
			self title hResizing: #rigid.
			self title layoutChanged.
			self adjustWidth: self optimalWidth .
			self adjustWidth.].
	
	
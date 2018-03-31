as yet unclassified
name: aString 
	"name := aString.
	titleMorph ifNotNilDo: [:Name already used in this class ->title | titleMorph name: name. ].
	self changed"
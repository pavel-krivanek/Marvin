as yet unclassified
name: aString 
	name := aString.
	titleMorph ifNotNil: [:title | titleMorph name: name. ].
	self changed
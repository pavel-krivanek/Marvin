as yet unclassified
name: aString 

	name := aString.
	stringMorph contents: name.
	self extent: self width @ stringMorph height.
	self changed
as yet unclassified
messageImplementedByClass: class

	| currentClass dictionary found |
	
	self inline: false.

	"currentClass := class.
	[currentClass ~= objectMemory nilObject]
		whileTrue:
		[dictionary := self fetchPointer: MessageDictionaryIndex ofObject: currentClass.
		dictionary = objectMemory nilObject ifTrue: [ ^ self falseObject ].
		found := self lookupMethodInDictionary: dictionary.
		found ifTrue: [ ^ self trueObject ].
		currentClass := self superclassOf: currentClass]."
	
	^ self falseObject.
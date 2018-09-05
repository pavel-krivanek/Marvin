support
gtInspectorRawIn: composite
	"This is the most basic presentation showing the state of the object"

	| result |
	
	result := self _PerformMessage: (Message selector: #gtInspectorRawIn: argument: composite) inContextOf: self.
	
	^ result == MarvinPrototype DNU 
		ifTrue: [ composite custom: GTObjectVariablesBrowser new ]
		ifFalse: [ result ]

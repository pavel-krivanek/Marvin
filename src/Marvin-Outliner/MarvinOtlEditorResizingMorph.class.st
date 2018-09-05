Class {
	#name : #MarvinOtlEditorResizingMorph,
	#superclass : #Morph,
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlEditorResizingMorph >> handlesMouseDown: evt [

	^ true
]

{ #category : #'as yet unclassified' }
MarvinOtlEditorResizingMorph >> initialize [

	super initialize.
	self color: Color black.
	self extent: 8@8.
]

{ #category : #'as yet unclassified' }
MarvinOtlEditorResizingMorph >> mouseDown: evt [

	self setProperty: #clickPoint toValue: evt cursorPoint.
]

{ #category : #'as yet unclassified' }
MarvinOtlEditorResizingMorph >> mouseMove: evt [ 
	| point |

	point := evt cursorPoint.

	self valueOfProperty: #clickPoint
		ifPresentDo: [ :firstClick | 
			(point dist: firstClick) > 3 
				ifTrue: [
					| newExtent | 
					newExtent := (point x - self owner position x)@ (point y - self owner position y).
					newExtent := ((newExtent x max: 100) @ (newExtent y max: 50)).
					self owner extent: newExtent.
					self move: self toPosition: owner bottomRight. ] ]
]

{ #category : #'as yet unclassified' }
MarvinOtlEditorResizingMorph >> mouseUp: evt [
	
	self owner resizeAction ifNotNilDo: [ :action |
		action value ].
	
]

Class {
	#name : #MarvinOtlResizingMorph,
	#superclass : #BorderedMorph,
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlResizingMorph >> handlesMouseDown: evt [

	^ true
]

{ #category : #'as yet unclassified' }
MarvinOtlResizingMorph >> initialize [

	super initialize.
	self color: Color black.
	self extent: 8@8.
]

{ #category : #'as yet unclassified' }
MarvinOtlResizingMorph >> mouseDown: evt [

	self setProperty: #clickPoint toValue: evt cursorPoint.
]

{ #category : #'as yet unclassified' }
MarvinOtlResizingMorph >> mouseMove: evt [ 
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
					self position: owner bottomRight. ] ]
]

{ #category : #'as yet unclassified' }
MarvinOtlResizingMorph >> mouseUp: evt [

	self owner owner owner adjustWidth: (self owner owner width).

	self owner owner owner adjustWidth.

	
]

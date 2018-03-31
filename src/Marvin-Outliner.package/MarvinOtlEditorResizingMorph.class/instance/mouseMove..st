as yet unclassified
mouseMove: evt 
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
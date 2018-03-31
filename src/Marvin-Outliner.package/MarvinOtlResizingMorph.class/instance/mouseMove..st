as yet unclassified
mouseMove: evt 
	| point |

	point := evt cursorPoint.

	self valueOfProperty: #clickPoint
		ifPresentDo: [ :firstClick | 
			(point dist: firstClick) > 3 
				ifTrue: [
					self owner extent: (point x - self owner position x)@ (point y - self owner position y).
					self move: self toPosition: point. ] ]
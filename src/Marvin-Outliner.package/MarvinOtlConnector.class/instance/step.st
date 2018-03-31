stepping and presenter
step

	| newVerts title origin end |

	title := anchors first  titleMorph.

	origin := title bounds topRight + (-8@8).
	
	((handler holder isNil 
		or: [ handler holder isHandMorph  ])
		or: [ handler owner isHandMorph ])
		ifFalse: [
			end := handler holder bounds pointNearestTo: origin. 
			handler position: end-(4@4).]
		ifTrue: [ end := handler center. ].

	newVerts := OrderedCollection new.
	newVerts add: origin.
	"newVerts add: (title localPointToGlobal: (title referenceButton bounds center))."
	newVerts add: handler center.
	self setVertices: newVerts asArray.

	self comeToFront.
	handler comeToFront.


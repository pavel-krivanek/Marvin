Class {
	#name : #MarvinOtlConnector,
	#superclass : #PolygonMorph,
	#instVars : [
		'anchors',
		'state',
		'handler'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #access }
MarvinOtlConnector >> anchors [ 

	^ anchors
]

{ #category : #access }
MarvinOtlConnector >> anchors: anArray [

	anchors := anArray
]

{ #category : #access }
MarvinOtlConnector >> canBeDragged [

	^ false
]

{ #category : #access }
MarvinOtlConnector >> from: aConnectionEnd to: anotherConnectionEnd [ 
	super initialize.
	self makeOpen.
	"self makeForwardArrow."
	"set my connectionEnds"
	self anchors: (Array with: aConnectionEnd with: anotherConnectionEnd) asOrderedCollection.
	handler holder: anotherConnectionEnd.

	self borderColor: Color black.
	self borderWidth: 1.
	self openInWorld
]

{ #category : #access }
MarvinOtlConnector >> initialize [

	super initialize.

	self borderColor: Color black.
	self sticky: false.

	handler := MarvinOtlConnectorHandler new.

	handler openInWorld..
]

{ #category : #access }
MarvinOtlConnector >> state [
	^ state
]

{ #category : #access }
MarvinOtlConnector >> state: aBoolean [ 
	state := aBoolean
]

{ #category : #'stepping and presenter' }
MarvinOtlConnector >> step [

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


]

{ #category : #'stepping and presenter' }
MarvinOtlConnector >> stepTime [
	
	^  200
]

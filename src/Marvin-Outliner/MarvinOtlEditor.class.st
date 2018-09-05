Class {
	#name : #MarvinOtlEditor,
	#superclass : #PluggableTextMorph,
	#instVars : [
		'resizingMorph',
		'resizeAction'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlEditor class >> on: aModel [

	| editor |

	editor := super on: aModel
		text: #getText
		accept: #setText:
		readSelection: nil
		menu: #codePaneMenu:shifted:.

	^ editor initializeFor: aModel

]

{ #category : #'as yet unclassified' }
MarvinOtlEditor >> drawOn: aCanvas [

	super drawOn: aCanvas.

	resizingMorph show..

	
]

{ #category : #'as yet unclassified' }
MarvinOtlEditor >> height [

	^ super height + resizingMorph height.
]

{ #category : #'as yet unclassified' }
MarvinOtlEditor >> initialize [

	resizingMorph := MarvinOtlEditorResizingMorph new.

	super initialize.

	self addMorph: resizingMorph.	

	self extent: 320 @ 120.
	self color: Color white.

	resizingMorph position: (self position x + super width)@(self position y + super height).

]

{ #category : #'as yet unclassified' }
MarvinOtlEditor >> initializeFor: aModel [

	self extent: 320 @ 120.
	self color: Color white.

	resizingMorph := MarvinOtlEditorResizingMorph new.
	resizingMorph position: (self position x + super width) 
				@ (self position y + super height).



]

{ #category : #accessing }
MarvinOtlEditor >> resizeAction [
	^resizeAction
]

{ #category : #accessing }
MarvinOtlEditor >> resizeAction: anObject [
	resizeAction := anObject
]

{ #category : #'as yet unclassified' }
MarvinOtlEditor >> width [

	^ super width + resizingMorph width.
]

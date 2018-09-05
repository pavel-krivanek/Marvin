Class {
	#name : #MarvinOtlHeaderButton,
	#superclass : #BorderedMorph,
	#instVars : [
		'action',
		'text'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlHeaderButton class >> onMorph: aMorph newStateSelector: aSymbol [

	^ (self new) 	toggleAction: (MessageSend receiver: aMorph selector: aSymbol).
]

{ #category : #accessing }
MarvinOtlHeaderButton >> action [
	"Answer the value of action"

	^ action
]

{ #category : #accessing }
MarvinOtlHeaderButton >> action: anObject [
	"Set the value of action"

	action := anObject
]

{ #category : #'as yet unclassified' }
MarvinOtlHeaderButton >> drawOn: aCanvas [ 
	
	super drawOn: aCanvas.

	aCanvas drawString: (self text asText allBold ) in: (self fullBounds insetBy: 2) font: nil color: Color black.

]

{ #category : #'as yet unclassified' }
MarvinOtlHeaderButton >> handlesMouseDown: evt [

	^ true.
]

{ #category : #'as yet unclassified' }
MarvinOtlHeaderButton >> initialize [

	super initialize.

	self borderWidth: 2.
	self borderColor: #raised.
	self color:  (Color r: 0.935 g: 0.935 b: 0.871).

	self extent: 16@16..
	self collapse.
	
	text := ' '.
]

{ #category : #'as yet unclassified' }
MarvinOtlHeaderButton >> minHeigh [

	^ 16
]

{ #category : #'as yet unclassified' }
MarvinOtlHeaderButton >> minWidth [

	^ 16
]

{ #category : #'as yet unclassified' }
MarvinOtlHeaderButton >> mouseDown: evt [

	(evt redButtonPressed and: [self containsPoint: evt cursorPoint])
		ifTrue:[ self action value ]
]

{ #category : #accessing }
MarvinOtlHeaderButton >> text [
	^ text
]

{ #category : #accessing }
MarvinOtlHeaderButton >> text: anObject [
	text := anObject
]

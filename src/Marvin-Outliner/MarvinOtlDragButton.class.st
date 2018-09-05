Class {
	#name : #MarvinOtlDragButton,
	#superclass : #BorderedMorph,
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlDragButton class >> onMorph: aMorph newStateSelector: aSymbol [

	^ (self new) 	toggleAction: (MessageSend receiver: aMorph selector: aSymbol).
]

{ #category : #'as yet unclassified' }
MarvinOtlDragButton >> handlesMouseDown: evt [

	^ true.
]

{ #category : #'as yet unclassified' }
MarvinOtlDragButton >> initialize [

	super initialize.

	self extent: 16@16..
	self color: Color lightGray.
	self borderWidth: 2.
	self borderColor: #raised..

]

{ #category : #'as yet unclassified' }
MarvinOtlDragButton >> minHeigh [

	^ 16
]

{ #category : #'as yet unclassified' }
MarvinOtlDragButton >> minWidth [

	^ 18
]

{ #category : #'as yet unclassified' }
MarvinOtlDragButton >> mouseDown: evt [

	(evt redButtonPressed and: [self containsPoint: evt cursorPoint])
		ifTrue:[
			evt hand grabMorph: self owner owner ].
]

{ #category : #accessing }
MarvinOtlDragButton >> toggleAction [
	^toggleAction
]

{ #category : #accessing }
MarvinOtlDragButton >> toggleAction: anObject [
	toggleAction := anObject
]

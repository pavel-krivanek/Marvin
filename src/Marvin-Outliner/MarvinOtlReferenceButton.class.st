Class {
	#name : #MarvinOtlReferenceButton,
	#superclass : #BorderedMorph,
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlReferenceButton class >> onMorph: aMorph newStateSelector: aSymbol [

	^ (self new) 	toggleAction: (MessageSend receiver: aMorph selector: aSymbol).
]

{ #category : #'as yet unclassified' }
MarvinOtlReferenceButton >> handlesMouseDown: evt [

	^ true.
]

{ #category : #'as yet unclassified' }
MarvinOtlReferenceButton >> initialize [

	super initialize.

	self extent: 16@16..
	self color: Color lightGray.
	self borderWidth: 2.
	self borderColor: #raised
	
]

{ #category : #'as yet unclassified' }
MarvinOtlReferenceButton >> minHeigh [

	^ 12
]

{ #category : #'as yet unclassified' }
MarvinOtlReferenceButton >> minWidth [

	^ 12
]

{ #category : #'as yet unclassified' }
MarvinOtlReferenceButton >> mouseDown: evt [

	(evt redButtonPressed and: [self containsPoint: evt cursorPoint])
		ifTrue:[
			evt hand grabMorph: self owner owner ].
]

{ #category : #accessing }
MarvinOtlReferenceButton >> toggleAction [
	^toggleAction
]

{ #category : #accessing }
MarvinOtlReferenceButton >> toggleAction: anObject [
	toggleAction := anObject
]

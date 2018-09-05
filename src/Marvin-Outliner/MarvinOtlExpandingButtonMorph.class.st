Class {
	#name : #MarvinOtlExpandingButtonMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'state',
		'expandedForm',
		'collapsedForm',
		'toggleAction'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph class >> onMorph: aMorph newStateSelector: aSymbol [

	^ (self new) 	toggleAction: (MessageSend receiver: aMorph selector: aSymbol).
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph >> collapse [
	state := #collapsed.
	toggleAction ifNotNil: [toggleAction value: state].
	self changed
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph >> drawOn: aCanvas [ 

	| offset |
	
	offset := self width - expandedForm width // 2.

	state = #expanded 
		ifTrue: [aCanvas paintImage: expandedForm at: self position + offset]
		ifFalse: [aCanvas paintImage: collapsedForm at: self position + offset]
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph >> expand [
	state := #expanded.
	toggleAction ifNotNil: [toggleAction value: state].
	self changed
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph >> handlesMouseDown: evt [

	^ true.
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph >> initialize [

	super initialize.

	expandedForm := SimpleHierarchicalListMorph expandedForm.
	collapsedForm := SimpleHierarchicalListMorph notExpandedForm.

	self extent: 16@16..
	self collapse.
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph >> minHeigh [

	^ 16
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph >> minWidth [

	^ 16
]

{ #category : #'as yet unclassified' }
MarvinOtlExpandingButtonMorph >> mouseDown: evt [

	(evt redButtonPressed and: [self containsPoint: evt cursorPoint])
		ifTrue:[
			state=#collapsed 
				ifTrue: [self expand] 
				ifFalse: [self collapse] ].
]

{ #category : #accessing }
MarvinOtlExpandingButtonMorph >> toggleAction [
	^toggleAction
]

{ #category : #accessing }
MarvinOtlExpandingButtonMorph >> toggleAction: anObject [
	toggleAction := anObject
]

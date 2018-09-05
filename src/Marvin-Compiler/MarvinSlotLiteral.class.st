Class {
	#name : #MarvinSlotLiteral,
	#superclass : #MarvinLiteral,
	#instVars : [
		'name',
		'type',
		'content',
		'arguments'
	],
	#category : 'Marvin-Compiler-Literals'
}

{ #category : #accessing }
MarvinSlotLiteral >> arguments [
	^arguments
]

{ #category : #accessing }
MarvinSlotLiteral >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
MarvinSlotLiteral >> content [
	^content
]

{ #category : #accessing }
MarvinSlotLiteral >> content: anObject [
	content := anObject
]

{ #category : #accessing }
MarvinSlotLiteral >> initialize [

	super initialize.
	

]

{ #category : #accessing }
MarvinSlotLiteral >> isDataSlot [

	^ type = #readSlot or: [ type = #assignSlot ].
]

{ #category : #accessing }
MarvinSlotLiteral >> name [ 

	^ name
]

{ #category : #accessing }
MarvinSlotLiteral >> name1 [
	^name
]

{ #category : #accessing }
MarvinSlotLiteral >> name: anObject [
	name := anObject
]

{ #category : #printing }
MarvinSlotLiteral >> printOn: aStream [

	aStream 
		nextPutAll: 'Slot: ', name asString, ' (', type asString, ') '.


	
]

{ #category : #accessing }
MarvinSlotLiteral >> type [
	^type
]

{ #category : #accessing }
MarvinSlotLiteral >> type: anObject [
	type := anObject
]

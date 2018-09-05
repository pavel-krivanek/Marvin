Class {
	#name : #MarvinObjectLiteral,
	#superclass : #MarvinLiteral,
	#instVars : [
		'slots'
	],
	#category : 'Marvin-Compiler-Literals'
}

{ #category : #'as yet unclassified' }
MarvinObjectLiteral >> initialize [

	slots := OrderedCollection new.
"	context := MarvinContext  new.
	context addInstruction: (context generator instrPushSelf).
	context addInstruction: (context generator instrReturnTop).
"
]

{ #category : #accessing }
MarvinObjectLiteral >> isObjectLiteral [

	^ true.
]

{ #category : #accessing }
MarvinObjectLiteral >> slots [
	^slots
]

{ #category : #accessing }
MarvinObjectLiteral >> slots: anObject [
	slots := anObject
]

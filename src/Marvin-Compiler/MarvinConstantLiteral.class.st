Class {
	#name : #MarvinConstantLiteral,
	#superclass : #MarvinLiteral,
	#instVars : [
		'content'
	],
	#category : 'Marvin-Compiler-Literals'
}

{ #category : #'as yet unclassified' }
MarvinConstantLiteral class >> for: anObject [

	^ self new content: anObject.
]

{ #category : #accessing }
MarvinConstantLiteral >> content [
	^content
]

{ #category : #accessing }
MarvinConstantLiteral >> content: anObject [
	content := anObject
]

{ #category : #accessing }
MarvinConstantLiteral >> isConstantLiteral [

	^ true
]

Class {
	#name : #MarvinOtlComponentTitle,
	#superclass : #Object,
	#instVars : [
		'outlinerComponent'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #accessing }
MarvinOtlComponentTitle >> model [

	^ outlinerComponent model
]

{ #category : #accessing }
MarvinOtlComponentTitle >> optimalWidth [

	^ 50
]

{ #category : #accessing }
MarvinOtlComponentTitle >> outlinerComponent [
	^outlinerComponent
]

{ #category : #accessing }
MarvinOtlComponentTitle >> outlinerComponent: anObject [
	outlinerComponent := anObject
]

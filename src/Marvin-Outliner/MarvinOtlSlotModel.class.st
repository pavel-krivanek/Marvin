Class {
	#name : #MarvinOtlSlotModel,
	#superclass : #Object,
	#instVars : [
		'str',
		'protobj'
	],
	#category : 'Marvin-Outliner'
}

{ #category : #'as yet unclassified' }
MarvinOtlSlotModel class >> on: anObject [

	^ self new.
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotModel >> codePaneMenu: aMenu shifted: shifted [

	^ StringHolder new codePaneMenu: aMenu shifted: shifted.

]

{ #category : #'as yet unclassified' }
MarvinOtlSlotModel >> doItContext [
  ^nil
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotModel >> doItReceiver [
  ^protobj
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotModel >> getText [
  ^str
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotModel >> selectedClass [
  ^nil
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotModel >> setModel: anObject [

	protobj := anObject
]

{ #category : #'as yet unclassified' }
MarvinOtlSlotModel >> setText: aText [
  str:=aText asString.
  Compiler evaluate: str for: protobj logged: false.
  ^true
]

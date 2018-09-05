Class {
	#name : #MarvinVMUnixConfig,
	#superclass : #PharoSUnixConfig,
	#category : 'Marvin-VM'
}

{ #category : #'as yet unclassified' }
MarvinVMUnixConfig >> executableName [
	^ 'marvin'
]

{ #category : #'as yet unclassified' }
MarvinVMUnixConfig >> interpreterClass [

	^ MarvinInterpreter 
]

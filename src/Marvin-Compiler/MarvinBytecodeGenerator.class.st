Class {
	#name : #MarvinBytecodeGenerator,
	#superclass : #Object,
	#category : 'Marvin-Compiler'
}

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> bytecodeFor: aSymbol [

	^ self bytecodeTable indexOf: aSymbol
							
		
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> bytecodeTable [

	
	^ #(
		send:
		resend:		
		pushSelf 		 
		pushLiteral: 		
		pop				
		returnTop		
	)
							
		
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> instrPop [

	^ {#pop }

	
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> instrPushLiteral: aLiteral [

	^ {#pushLiteral:. aLiteral}

	
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> instrPushSelf [

	^ {#pushSelf}

	
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> instrResend: aSelector numArgs: numArgs [

	^ {#resend:. aSelector. numArgs}

	
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> instrReturnImplicit [

	^ {#returnImplicit }

	
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> instrReturnTop [

	^ {#returnTop }

	
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> instrSelfSend: aSelector numArgs: numArgs [

	^ {#selfSend:. aSelector. numArgs}

	
]

{ #category : #'as yet unclassified' }
MarvinBytecodeGenerator class >> instrSend: aSelector numArgs: numArgs [

	^ {#send:. aSelector. numArgs}

	
]

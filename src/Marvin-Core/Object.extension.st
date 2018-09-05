Extension { #name : #Object }

{ #category : #'*Marvin-Core' }
Object >> _PerformMessage: aMessage inContextOf: anObject [

	^ aMessage sendTo: anObject 
]

{ #category : #'*Marvin-Core' }
Object >> _PrimitiveAt: anIndex [

	<primitive: 173 error: ec>
	self primitiveFailed
]

{ #category : #'*Marvin-Core' }
Object >> _PrimitiveAt: anIndex put: anObject [

	<primitive: 174 error: ec>
	self primitiveFailed
]

Extension { #name : #Behavior }

{ #category : #'*Marvin-Core' }
Behavior >> _PerformMessage: aMessage inContextOf: anObject [

	^ self classAndMethodFor: aMessage selector
		do: [ :class :method | method valueWithReceiver: anObject arguments: aMessage arguments ]
		ifAbsent: [ MarvinPrototype DNU ]		


]

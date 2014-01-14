generating
slotList: aCollection

	aCollection size = 1
		ifTrue: [ ^ OrderedCollection withAll: aCollection first value ].
		
	^ aCollection first value 
		addAll: aCollection third value;
		yourself
	


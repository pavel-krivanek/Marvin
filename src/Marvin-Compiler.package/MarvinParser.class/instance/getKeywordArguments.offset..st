generating
getKeywordArguments: aCollection offset: offset

	| arguments send |
	
	send := OrderedCollection withAll: { (aCollection at: 1+offset) value. (aCollection at: 2+offset) value }.
				
	(aCollection size = (3+offset))
		ifTrue: [ 
			| col |
			col := aCollection at: 3+offset.
			1 to: col size do: [:i | send add: (col at: i) first. send add: (col at: i) second ].
	].
	
	arguments := OrderedCollection new.

	2 to: send size by: 2 do: [ :i |
		arguments add: (send at: i).
	].
	^ arguments.

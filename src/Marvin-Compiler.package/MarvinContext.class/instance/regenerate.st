accessing
regenerate

	literals = OrderedCollection new.
	selectors = OrderedCollection new..

	instructions do: [ :i |
		
		i first = #pushLiteral: 
			ifTrue: [ self addLiteral: i second ]. 
			
		(i first = #send:)
			ifTrue: [ self addSelector: i second ].
			 
		(i first = #resend:)
			ifTrue: [ self addSelector: i second ].

		(i first = #selfSend:)
			ifTrue: [ self addSelector: i second ].
	].
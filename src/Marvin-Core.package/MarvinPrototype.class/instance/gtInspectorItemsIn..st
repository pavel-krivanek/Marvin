gt-inspector-extension
gtInspectorItemsIn: composite
	<gtInspectorPresentationOrder: 0> 
	^ (composite fastList)
		title: 'Slots';
		display: [ 
			self asOrderedCollection ];
		beMultiple;	
		format: [ :each | GTObjectPrinter asTruncatedTextFrom: each ];
		send: [ :result | result isNil 
			ifTrue:[nil]
			ifFalse:[ (result size = 1) 
				ifTrue: [result anyOne] 
				ifFalse: [self species withAll: result]]]

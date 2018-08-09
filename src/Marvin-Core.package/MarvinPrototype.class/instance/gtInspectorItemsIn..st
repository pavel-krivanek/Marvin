support
gtInspectorItemsIn: composite
	<removed_gtInspectorPresentationOrder: 0> 
	^ composite table
		title: 'Slots';
		display: [ {} ];
		column: 'Name' evaluated: [ :each | 'each name' ];
		column: 'Value' evaluated: [ :each | 'each value asString' ]
support
gtInspectorActions


[ | result |
	
	result := self PerformMessage: (Message selector: #gtInspectorActions) inContextOf: self.
	
		
	^ result == MarvinPrototype DNU 
		ifTrue: [ 
				| all |
	all := (Pragma
		allNamed: #gtInspectorAction
		from: self class
		to: ProtoObject)
		collect: [ :eachPragma | 
			result := self PerformMessage: (Message selector: eachPragma methodSelector) inContextOf: self.
			(result = MarvinPrototype DNU) ifTrue: [ 
				GLMAction new ]
			"thisContext
				object: self
				perform: eachPragma methodSelector
				withArguments: #()
				inClass: MarvinPrototype" ].
	^ all
		asSortedCollection: [ :a :b | 
			| first second |
			first := a isCategorized
				ifTrue: [ a category , a title ]
				ifFalse: [ a title ].
			second := b isCategorized
				ifTrue: [ b category , b title ]
				ifFalse: [ b title ].
			first < second ]
			
			 ]
		ifFalse: [ result ]
 ].
	^ {  }
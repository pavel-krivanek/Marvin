as yet unclassified
wantsDroppedMorph: aMorph event: evt

	(aMorph isKindOf: MarvinOtlConnectorHandler ) 
		ifTrue: [ 
			aMorph holder: self.
			^ false ].


	^ (aMorph isKindOf: MarvinOtlSlot) or: [aMorph isKindOf: MarvinOtlConnectorHandler ] .

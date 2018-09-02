as yet unclassified
addElement: aMorph 

	tabContainer ifNil:  [
		tabContainer := MarvinOtlTabContainer new.
		self addMorph: tabContainer].

	tabContainer addMorph: aMorph.
	
	self layoutChanged
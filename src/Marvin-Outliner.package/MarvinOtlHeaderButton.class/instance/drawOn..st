as yet unclassified
drawOn: aCanvas 
	
	super drawOn: aCanvas.

	aCanvas drawString: (self text asText allBold ) in: (self fullBounds insetBy: 2) font: nil color: Color black.

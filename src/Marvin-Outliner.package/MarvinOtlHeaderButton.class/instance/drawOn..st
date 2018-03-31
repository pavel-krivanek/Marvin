as yet unclassified
drawOn: aCanvas 

	| |
	
	super drawOn: aCanvas.

	aCanvas drawString: ('E' asText allBold )in: self fullBounds  font: nil color: Color black.

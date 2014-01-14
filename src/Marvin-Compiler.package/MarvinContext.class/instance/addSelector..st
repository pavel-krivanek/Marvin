as yet unclassified
addSelector: object  

	| symbol |
	
	symbol := object asSymbol.

	^ selectors 
		indexOf: symbol 
		ifAbsent: [selectors add: symbol. selectors indexOf: symbol].

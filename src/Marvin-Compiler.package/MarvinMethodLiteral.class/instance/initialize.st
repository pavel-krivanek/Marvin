as yet unclassified
initialize

	super initialize.

	slots := OrderedCollection new.
	context := MarvinContext  new.
	context addInstruction: (context generator instrReturnImplicit ).

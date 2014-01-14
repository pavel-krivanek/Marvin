as yet unclassified
superclassSend
	"Send a message to self, starting lookup with the superclass of the class
	 containing the currently executing method."
	"Assume: messageSelector and argumentCount have been set, and that
	 the receiver and arguments have been pushed onto the stack,"
	"Note: This method is inlined into the interpreter dispatch loop."
	| rcvr |
	<sharedCodeNamed: 'commonSupersend' inCase: #singleExtendedSuperBytecode>
	lkupClass := self superclassOf: (self methodClassOf: method).
	self assert: lkupClass ~= objectMemory nilObject.

	rcvr := self internalStackValue: argumentCount.
	((self fetchClassOf: rcvr) = (objectMemory splObj: ClassPrototype))
		ifTrue: [ self delegationResend  ]
		ifFalse: [ self commonSend. ]
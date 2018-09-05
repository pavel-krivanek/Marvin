Class {
	#name : #MarvinParser,
	#superclass : #SmaCCParser,
	#instVars : [
		'contexts'
	],
	#category : 'Marvin-Compiler'
}

{ #category : #'generated-accessing' }
MarvinParser class >> cacheId [
	^'2018-03-31T08:54:05.773722+02:00'
]

{ #category : #generated }
MarvinParser class >> definitionComment [
"#Definition extracted from old style definition comments
<identifier> :
	[a-zA-Z_] [a-zA-Z0-9_]*
	;

<parentSlotName> :
	<identifier> \*
	;

<keyword> :
	<identifier> \:
	;

<multikeyword>	:
	<identifier> \: (<identifier> \: )+
	;
	
<argumentName> :
	\: <identifier>
	;

<operatorChar> :
	\! | \@ |  \$ | \% | \& | \* | \- | \+ | \= | \~ | \/ | \? | \< | \> | \, | \; | \\
	;
	
<binaryKeyword> :
	<operatorChar>+
	;
	
<character> :	
	\$ .	
	;	

<base> :
	[0-9]+ r
	;
	
<exponent> :
	e [\+ | \-]? [0-9]+
	;
	
<integer> :
	<base>? [0-9A-Z]+ <exponent>?
	;
	
<float> :
	<base>? [0-9A-Z]+ \. [0-9A-Z]+ <exponent>?
	;

<negative> :
	\-
	;
	
<number> :
	<negative>? ( <integer> | <float> )
	;
		
<resend> :
	resend	
	;	
		
<self> :
	self	
	;		
		
<string>	:
	\' [^\']* \' (\' [^\']* \')*
	;

<symbol> :
	 \# <string>											
|	\# <identifier> 													
|	\# <binaryKeyword>													
|	\# <keyword>
|	\# <multikeyword>
	;	

<comment> :
	\"" 
	; # see my method comment

<whitespace> :
	\s+ 
	; 
	

Start :
	MethodSlots Code													{ #codeContext: } 
|	MethodSlots  														{ #codeContext: }
|	Code  															{ #codeContext: }
	;
			
SlotName:
	<identifier>														{ #liftFirstValue: } 
	;

ParentSlotName:
	<parentSlotName>												{ #liftFirstValue: } 
	;
	
ParentSlot :
	ParentSlotName													{ #parentSlot: } 
|	ParentSlotName ""="" Expression								{ #parentSlot: }
|	ParentSlotName ""<-"" Expression 								{ #parentSlot: }  
	;

DataSlot :
	SlotName														{ #dataSlot: } 
|	SlotName ""="" Expression										{ #dataSlot: }
|	SlotName ""<-"" Expression								{ #dataSlot: }  
	;
	
UnarySlot :
	SlotName ""="" MethodObject										{ #unarySlot: } 
	;

BinarySlot :
	<binaryKeyword> <identifier> ""="" MethodObject						{ #binarySlot: } # one implicit argument slot
|	""="" <identifier> ""="" MethodObject								{ #binarySlot: } # one implicit argument slot
	;

KeywordNextParameters :
	#epsilon
|	<keyword> <identifier> KeywordNextParameters					{ #keywordNextParameters: } 
	;

KeywordSlotDeclaration :
	<keyword> <identifier> KeywordNextParameters						{ #keywordSlotDeclaration: } 
	;
	
KeywordSlot:
	KeywordSlotDeclaration ""="" MethodObject 							{ #keywordSlot: } 
	;		

ArgumentSlot :
	<argumentName>												{ #argumentSlot: } 
	;	
		
Slot :
	ParentSlot														{ #liftFirstValue:  } |	DataSlot															{ #liftFirstValue:  } |	UnarySlot														{ #liftFirstValue:  } 
|	BinarySlot														{ #liftFirstValue:  } 
| 	KeywordSlot														{ #liftFirstValue:  } 
	;
	
MethodSlot :
	DataSlot															{ #liftFirstValue:  } 
| 	ArgumentSlot													{ #liftFirstValue:  } 
	;	

SlotList :
	# epsilon														{ OrderedCollection new } 
| 	Slot																{ #slotList: }
|	SlotList ""."" Slot 													{ #slotList: }
	;
	
MethodSlotList :
	# epsilon														{ OrderedCollection new } 
| 	MethodSlot														{ #slotList: }
|	MethodSlotList ""."" MethodSlot 										{ #slotList: }
	;	

Slots :
	""|"" SlotList ""|""													{ #liftSecondValue:  } 
|	""|"" SlotList ""."" ""|""													{ #liftSecondValue:  } 
	;
	
MethodSlots :
	""|"" MethodSlotList ""|""												{ #liftSecondValue:  } 
|	""|"" MethodSlotList ""."" ""|""												{ #liftSecondValue:  } 
	;	

Block :
	""["" ""]"" 															{ #block: }
|	""["" MethodSlots ""]"" 												{ #block: }
|	""["" Code ""]"" 														{ #blockWithoutSlots: }
|	""["" MethodSlots Code ""]"" 											{ #block: }
	;
	
RegularObject :
	""("" "")""															{ #object: }
|	""("" Slots "")"" 														{ #object: }
	;

MethodObject :
	""{"" ""}""															{ #method: }
|	""{"" MethodSlots ""}"" 												{ #method: }
|	""{"" Code ""}"" 														{ #method: }
|	""{"" MethodSlots Code ""}"" 											{ #method: }
	;
	
Object:
	RegularObject													{ #liftFirstValue: } 
| 	Block															{ #liftFirstValue: } 
	;

Code :
	ExprSequence ""."" ""^"" Expression "".""? 								{ #returnLongExpressionCode: } 
| 	""^"" Expression "".""? 												{ #returnSingleExpresion: } 
|	ExprSequence "".""? 												{ #returnImplicit: } 
	;

ExprSequence :
	Expression														{ #liftFirstValue: } 
|	ExprSequence ""."" Expression										{ #nextExpression: } 
	;

Expression :
	KeywordMessage												{ #liftFirstValue: } 
	;

KeywordCapPart :
	<keyword> BinaryMessage										{ #keywordCapPart:  }
	;

KeywordMessage :
	BinaryMessage <keyword> BinaryMessage KeywordCapPart*			{ #sendKeyword:  }
|	<resend> <keyword> BinaryMessage  KeywordCapPart*				{ #resendKeyword:  }
|	<keyword> BinaryMessage KeywordCapPart*						{ #selfSendKeyword:  }
|	BinaryMessage													{ #liftFirstValue: } 
	;	
	
BinaryMessage :
	BinaryMessage <binaryKeyword> UnaryMessage					{ #sendBinary:  }
|	BinaryMessage ""="" UnaryMessage					{ #sendBinary:  }
|	<resend> <binaryKeyword> UnaryMessage						{ #resendBinary:  }
|	<resend> ""="" UnaryMessage						{ #resendBinary:  }
| 	<binaryKeyword> UnaryMessage									{ #selfSendBinary:  }
| 	""="" UnaryMessage									{ #selfSendBinary:  }
|	UnaryMessage													{ #liftFirstValue: } 
	;
		
	
UnaryMessage :
	UnaryMessage <identifier> 										{ #send:  }
|	<resend> <identifier> 											{ #resend:  }
|	<identifier> 														{ #selfSend:  }
|	<self> 															{ #pushSelf:  }
|	Primary															{ #liftFirstValue: } 							
	;
	
Primary : 
	Literal															{ #liftFirstValue: }	
|	""("" Expression "")""													{ #liftSecondValue: }							
	;

BaseLiteral:
	<number>														{ #pushNumber: }
| 	<string>														{ #pushString: }
| 	<character>														{ #pushCharacter: }
|	<symbol>														{ #pushSymbol: }		
|	""#("" Array "")""														{ #pushArray: }
	; 	

Array: 
	# epsilon														{ OrderedCollection new }
|	Array ArrayLiteral 												{ '1' value add: '2' value ; yourself }
	;

ArraySymbol :
	<identifier>														{ #arraySymbol2:  }
|	<binaryKeyword>													{ #arraySymbol2:  } 
|	<keyword> 														{ #arraySymbol2:  }
|	<multikeyword>													{ #arraySymbol2:  }
|	<self>															{ #arraySymbol2:  }
|	<resend>														{ #arraySymbol2:  }
	;
	
ArrayLiteral:
	<number>														{ #arrayNumber: }
| 	<string>														{ #arrayString: }
|	<character>														{ #arrayCharacter: }
|	<symbol>														{ #arraySymbol: }		
|	ArraySymbol														{ #liftFirstValue:  }
|	RegularObject													{ #arrayObject:  }		 # !!!
|	""#("" Array "")"" 													{ '2' value asArray }
	;

Literal :
	BaseLiteral														{ #liftFirstValue: } 
|	Object															{ #pushObject: }  
	;"
]

{ #category : #'generated-accessing' }
MarvinParser class >> scannerClass [
	^MarvinScanner
]

{ #category : #generated }
MarvinParser class >> startingStateForStart [
	^ 1
]

{ #category : #generating }
MarvinParser >> annotation: aCollection [

	^ self stringFromLiteral: aCollection first value.
	
	


]

{ #category : #generating }
MarvinParser >> argumentSlot: aCollection [

	| slot |
	
	slot := MarvinSlotLiteral new
			name: aCollection first value;	
			type: #argumentSlot.
	
	^ OrderedCollection with: slot.


]

{ #category : #'generating-literals' }
MarvinParser >> arrayCharacter: aCollection [

	^ aCollection first value second asCharacter
	
]

{ #category : #'generating-literals' }
MarvinParser >> arrayNumber: aCollection [

	^ aCollection first value asNumber.
	
]

{ #category : #'generating-literals' }
MarvinParser >> arrayObject: aCollection [

	^ aCollection first value 
	
]

{ #category : #'generating-literals' }
MarvinParser >> arrayString: aCollection [

	^ aCollection first value asString.
	
]

{ #category : #'generating-literals' }
MarvinParser >> arraySymbol2: aCollection [

	^ aCollection first value withoutQuoting asSymbol.
	
]

{ #category : #'generating-literals' }
MarvinParser >> arraySymbol: aCollection [

	^ aCollection first value allButFirst withoutQuoting asSymbol.
	
]

{ #category : #generating }
MarvinParser >> binarySlot: aCollection [

	| slot selector args |
	
	selector := aCollection first value.
	args := { aCollection second value }.
	
	slot := MarvinSlotLiteral new
			name: selector;
			type: #methodSlot.
	
	slot arguments: args.
			
	slot content: aCollection fourth value.
	slot content acceptArgumetsNamed: slot arguments.
	
	^ OrderedCollection with: slot.


]

{ #category : #generating }
MarvinParser >> block: aCollection [

	| block |
	
	block := MarvinBlockLiteral new.
	
	aCollection size = 3
		ifTrue: [
			block slots: aCollection second value.
			 ].
	
	aCollection size = 4
		ifTrue: [ 
			block slots: aCollection second value.
			block context: aCollection third value.
		 ].

	^ block.
	


]

{ #category : #generating }
MarvinParser >> blockWithoutSlots: aCollection [

	| block |
	
	block := MarvinBlockLiteral new.
	
	block context: aCollection second value.
		
	^ block.
	


]

{ #category : #generating }
MarvinParser >> codeContext: aCollection [ 

	| val gen method methodLiteral |
	
	methodLiteral := MarvinMethodLiteral new.

	(aCollection size = 2) 
		ifTrue: [ 
			methodLiteral slots: aCollection first value.
			methodLiteral context: aCollection second value ].

	(aCollection size = 1) 
		ifTrue: [ 
			(aCollection first value isCollection )
				ifTrue: [
					methodLiteral slots: aCollection first value. ]
				ifFalse: [
					methodLiteral context: aCollection first value ] ].

	gen := MarvinNativeBytecodeGenerator new.
	gen returnSelf: false.

	method := gen methodFrom: methodLiteral owner: MarvinPrototype lobby.
	val := gen runInLobby: method.

	^ val

]

{ #category : #'as yet unclassified' }
MarvinParser >> context [
	
	^ contexts first
]

{ #category : #generating }
MarvinParser >> dataSlot: aCollection [ 

	| slot slots |

	slots := OrderedCollection new.

	" read slot "
	slot := (MarvinSlotLiteral new)
				name: aCollection first value;
				type: #assignSlot.
	aCollection size = 3 
		ifTrue: [
			| cont |.
			slot type: ((aCollection second value = '=')
				ifTrue:  [ #readSlot ]
				ifFalse: [ #assignSlot ]).
			cont := aCollection third.
			cont addInstruction: (cont generator instrReturnTop ).
			slot content: cont.
		]
		ifFalse: [slot content: nil].
		
	slots add: slot copy.
	
	^slots 
		

]

{ #category : #generating }
MarvinParser >> getKeywordArguments: aCollection offset: offset [

	| arguments send |
	
	send := OrderedCollection withAll: { (aCollection at: 1+offset) value. (aCollection at: 2+offset) value }.
				
	(aCollection size = (3+offset))
		ifTrue: [ 
			| col |
			col := aCollection at: 3+offset.
			1 to: col size do: [:i | send add: (col at: i) first. send add: (col at: i) second ].
	].
	
	arguments := OrderedCollection new.

	2 to: send size by: 2 do: [ :i |
		arguments add: (send at: i).
	].
	^ arguments.

]

{ #category : #generating }
MarvinParser >> getKeywordSelector: aCollection offset: offset [

	| selector send |
	
	send := OrderedCollection withAll: { (aCollection at: 1+offset) value. (aCollection at: 2+offset) value }.
				
	(aCollection size = (3+offset))
		ifTrue: [ 
			| col |
			col := aCollection at: 3+offset.
			1 to: col size do: [:i | send add: (col at: i) first. send add: (col at: i) second ].
	].
	
	selector := ''.

	1 to: send size by: 2 do: [ :i |
		selector := selector, 	(send at: i).
	].

	^ selector.

]

{ #category : #'initialize-release' }
MarvinParser >> initialize [

	super initialize.
	
	contexts := OrderedCollection new.
	contexts add: MarvinContext new.
]

{ #category : #generating }
MarvinParser >> keywordCapPart: aCollection [

	^ { aCollection first value. aCollection second value }
]

{ #category : #generating }
MarvinParser >> keywordNextParameters: aCollection [

	| previous |

	previous := aCollection third value.
	previous ifEmpty: [
		previous := { String new. OrderedCollection new } ].

	^ { 
		aCollection first value, previous first.
		{aCollection second value}, previous second.
	} 
		


]

{ #category : #generating }
MarvinParser >> keywordSlot: aCollection [

	| slot selector args |
	
	selector := aCollection first value first.
	args := aCollection first value second.

	slot := MarvinSlotLiteral new
			name: selector;	
			type: #methodSlot.
	
	slot arguments: args.
			
	slot content: aCollection third value.

	slot content acceptArgumetsNamed: args.
	
	^ OrderedCollection with: slot.


]

{ #category : #generating }
MarvinParser >> keywordSlotDeclaration: aCollection [

	| previous |
	previous := aCollection third value.

	previous ifEmpty: [ 
		^ { aCollection first value. { aCollection second value }}
	].

	^ { 
		aCollection first value, previous first.
		{aCollection second value}, previous second.
	} 
		
		


]

{ #category : #generating }
MarvinParser >> method: aCollection [

	| methodLiteral |
	
	methodLiteral := MarvinMethodLiteral new.
	
	aCollection size = 2
		ifTrue: [ ^ methodLiteral ].
	
	(aCollection size = 3) 
		ifTrue: [ 
			(aCollection second value isCollection )
				ifTrue: [
					methodLiteral slots: aCollection second value. ]
				ifFalse: [
					methodLiteral context: aCollection second value ] ].

	(aCollection size = 4) 
		ifTrue: [ 
			methodLiteral slots: aCollection second value.
			methodLiteral context: aCollection third value ].

	^ methodLiteral.
	


]

{ #category : #generating }
MarvinParser >> nextExpression: aCollection [

	| context |
	
	context := aCollection first value.

	context addInstruction: (context generator instrPop).

	context + aCollection third value.

	^ context
]

{ #category : #generating }
MarvinParser >> object: aCollection [

	| object |
	
	object := MarvinObjectLiteral new.
	
	aCollection size = 3
		ifTrue: [
			object slots: aCollection second value.
			 ].

	^ object.
	


]

{ #category : #generating }
MarvinParser >> parentSlot: aCollection [ 

	| slot slots |

	slots := OrderedCollection new.

	slot := (MarvinSlotLiteral new)
				name: aCollection first value.

	aCollection size = 3 
		ifTrue: [
			| cont |.
			slot type: ((aCollection second value = '=')
				ifTrue:  [ #parentSlot ]
				ifFalse: [ #readWriteParentSlot ]).
			cont := aCollection third.
			cont addInstruction: (cont generator instrReturnTop ).
			slot content: cont.
		]
		ifFalse: [slot content: nil].
		
	slots add: slot copy.
	
	^slots.

]

{ #category : #'generating-literals' }
MarvinParser >> pushArray: aCollection [

	| array context |
	
	array := Array withAll: aCollection second value.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: array)).
	
	^ context.
]

{ #category : #'generating-literals' }
MarvinParser >> pushCharacter: aCollection [

	| char context |
	
	char := aCollection first value second asCharacter.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: char)).
	
	^ context.
]

{ #category : #generating }
MarvinParser >> pushNumber: aCollection [

	| number context |
	
	number := aCollection first value asNumber.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: number)).
	
	^ context.
]

{ #category : #generating }
MarvinParser >> pushObject: aCollection [

	| object context |
	
	object := aCollection first value.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: object).
	
	^ context.
]

{ #category : #generating }
MarvinParser >> pushSelf: aCollection [

	| context |
	
	context := MarvinContext new.
	context addInstruction: (context generator instrPushSelf).
	
	^ context.
]

{ #category : #'generating-literals' }
MarvinParser >> pushString: aCollection [

	| string context |
	
	string := self stringFromLiteral: aCollection first value.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: string)).
	
	^ context.
]

{ #category : #'generating-literals' }
MarvinParser >> pushSymbol: aCollection [

	| symbol context |
	
	symbol := self symbolFromLiteral: aCollection first value asSymbol.
		
	context := MarvinContext new.
	context addInstruction: (context generator instrPushLiteral: (MarvinConstantLiteral for: symbol)).
	
	^ context.
]

{ #category : #'generated-reduction actions' }
MarvinParser >> reduceActionForArray2: nodes [
	^ (nodes at: 1) value
		add: (nodes at: 2) value;
		yourself
]

{ #category : #'generated-reduction actions' }
MarvinParser >> reduceActionForArrayLiteral7: nodes [
	^ (nodes at: 2) value asArray
]

{ #category : #'generated-reduction actions' }
MarvinParser >> reduceActionForKeywordCapPart_1: nodes [
	^ OrderedCollection new
]

{ #category : #'generated-reduction actions' }
MarvinParser >> reduceActionForKeywordCapPart_2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #'generated-reduction actions' }
MarvinParser >> reduceActionFor____2: nodes [
	^ nodes at: 1
]

{ #category : #generated }
MarvinParser >> reduceTable [
^#(
	#(57 0 #reduceFor:) 
	#(37 0 #reduceFor:) 
	#(49 1 #selfSend:) 
	#(58 1 #pushCharacter:) 
	#(58 1 #pushNumber:) 
	#(49 1 #pushSelf:) 
	#(58 1 #pushString:) 
	#(58 1 #pushSymbol:) 
	#(41 1 #liftFirstValue:) 
	#(52 1 #pushObject:) 
	#(43 0 #nil) 
	#(50 1 #liftFirstValue:) 
	#(44 1 #liftFirstValue:) 
	#(45 1 #liftFirstValue:) 
	#(42 1 #liftFirstValue:) 
	#(49 1 #liftFirstValue:) 
	#(51 1 #liftFirstValue:) 
	#(52 1 #liftFirstValue:) 
	#(56 1 #codeContext:) 
	#(45 2 #selfSendBinary:) 
	#(54 1 #liftFirstValue:) 
	#(65 1 #argumentSlot:) 
	#(35 1 #liftFirstValue:) 
	#(37 1 #slotList:) 
	#(33 1 #dataSlot:) 
	#(39 2 #block:) 
	#(36 0 #reduceFor:) 
	#(40 2 #object:) 
	#(47 0 #reduceActionForKeywordCapPart_1:) 
	#(49 2 #resend:) 
	#(43 1 #reduceActionFor____2:) 
	#(60 2 #returnImplicit:) 
	#(49 2 #send:) 
	#(56 2 #codeContext:) 
	#(58 3 #pushArray:) 
	#(61 1 #arraySymbol2:) 
	#(59 1 #arrayCharacter:) 
	#(59 1 #arrayNumber:) 
	#(59 1 #arrayString:) 
	#(59 1 #arraySymbol:) 
	#(59 1 #arrayObject:) 
	#(57 2 #reduceActionForArray2:) 
	#(59 1 #liftFirstValue:) 
	#(64 3 #liftSecondValue:) 
	#(39 3 #blockWithoutSlots:) 
	#(39 3 #block:) 
	#(53 1 #liftFirstValue:) 
	#(34 1 #liftFirstValue:) 
	#(36 1 #slotList:) 
	#(48 1 #parentSlot:) 
	#(40 3 #object:) 
	#(51 3 #liftSecondValue:) 
	#(60 3 #returnSingleExpresion:) 
	#(44 3 #selfSendKeyword:) 
	#(45 3 #resendBinary:) 
	#(42 3 #nextExpression:) 
	#(45 3 #sendBinary:) 
	#(64 4 #liftSecondValue:) 
	#(37 3 #slotList:) 
	#(33 3 #dataSlot:) 
	#(39 4 #block:) 
	#(29 0 #reduceFor:) 
	#(38 3 #liftSecondValue:) 
	#(47 2 #reduceActionForKeywordCapPart_2:) 
	#(44 4 #resendKeyword:) 
	#(44 4 #sendKeyword:) 
	#(59 3 #reduceActionForArrayLiteral7:) 
	#(30 3 #keywordSlotDeclaration:) 
	#(31 3 #keywordSlot:) 
	#(38 4 #liftSecondValue:) 
	#(36 3 #slotList:) 
	#(48 3 #parentSlot:) 
	#(28 3 #unarySlot:) 
	#(46 2 #keywordCapPart:) 
	#(60 5 #returnLongExpressionCode:) 
	#(27 4 #binarySlot:) 
	#(32 2 #method:) 
	#(29 3 #keywordNextParameters:) 
	#(32 3 #method:) 
	#(32 4 #method:)
	).
]

{ #category : #generating }
MarvinParser >> resend: aCollection [ 
	| identifier context |
	identifier := aCollection second value.
	context := MarvinContext new.
	context addInstruction: context generator instrPushSelf.
	context addInstruction: (context generator instrResend: identifier numArgs: 0).
	^context
]

{ #category : #generating }
MarvinParser >> resendBinary: aCollection [

	| operator argument context |
	
	operator := aCollection second value.
	argument := aCollection third value.
	
	context := argument.
	context addInstruction: (context generator instrResend: operator numArgs: 1).
	
	^ context.
]

{ #category : #generating }
MarvinParser >> resendKeyword: aCollection [

	| selector arguments context |

	selector := self getKeywordSelector: aCollection offset: 0.
	arguments := self getKeywordArguments: aCollection offset: 0.
	
	context := MarvinContext new.

	arguments do: [:arg |
		context + arg.
	].

	context addInstruction: (context generator instrResend: selector numArgs: arguments size).

	^ context
]

{ #category : #generating }
MarvinParser >> returnImplicit: aCollection [

	| context |

	context := aCollection first value.
	context addInstruction: (context generator instrReturnImplicit  ).

	^ context regenerate
]

{ #category : #generating }
MarvinParser >> returnLongExpressionCode: aCollection [ 
	
	| context |

	context := aCollection first value.
	context addInstruction: (context generator instrPop ).
	context + (aCollection at: 4) value.
	context addInstruction: (context generator instrReturnTop ).

	^ context regenerate
]

{ #category : #generating }
MarvinParser >> returnSingleExpresion: aCollection [

	| context |

	context := aCollection second value.
	context addInstruction: (context generator instrReturnTop ).

	^ context regenerate
]

{ #category : #generating }
MarvinParser >> selfSend: aCollection [

	| identifier context |
	
	identifier := aCollection first value.
	
	context := MarvinContext new.
	context addInstruction: (context generator instrPushSelf). 
	context addInstruction: (context generator instrSelfSend: identifier numArgs: 0).

	
	
	^ context.
]

{ #category : #generating }
MarvinParser >> selfSendBinary: aCollection [

	| operator argument context |

	operator := aCollection first value.
	argument := aCollection second value.

	context := MarvinContext new.
	context addInstruction: (context generator instrPushSelf).
	context + argument.
	context addInstruction: (context generator instrSend: operator numArgs: 1).
	
	^ context.
]

{ #category : #generating }
MarvinParser >> selfSendKeyword: aCollection [

	| selector arguments context |

	selector := self getKeywordSelector: aCollection offset: 0.
	arguments := self getKeywordArguments: aCollection offset: 0.

	context := MarvinContext new.

	context addInstruction: (context generator instrPushSelf). 

	arguments do: [:arg |
		context + arg.
	].

	context addInstruction: (context generator instrSelfSend: selector numArgs: arguments size).

	^ context
]

{ #category : #generating }
MarvinParser >> send: aCollection [

	| identifier context |
	
	context := aCollection first value.

	identifier := aCollection second value.
	
	context addInstruction: (context generator instrSend: identifier  numArgs: 0 ).

	^ context.
]

{ #category : #generating }
MarvinParser >> sendBinary: aCollection [

	| operator context |
	
	operator := aCollection second value.
	
	context := aCollection first value. 	
	
	context + aCollection third value.
	context addInstruction: (context generator instrSend: operator  numArgs: 1).
	
	^ context.
]

{ #category : #generating }
MarvinParser >> sendKeyword: aCollection [

	| selector arguments context |

	selector := self getKeywordSelector: aCollection offset: 1.
	arguments := self getKeywordArguments: aCollection offset: 1.

	context := aCollection first value.

	arguments do: [:arg |
		context + arg.
	].

	context addInstruction: (context generator instrSend: selector  numArgs: arguments size) .

	^ context
]

{ #category : #generating }
MarvinParser >> slotList: aCollection [

	aCollection size = 1
		ifTrue: [ ^ OrderedCollection withAll: aCollection first value ].
		
	^ aCollection first value 
		addAll: aCollection third value;
		yourself
	


]

{ #category : #'generating-literals' }
MarvinParser >> stringFromLiteral: aString [

	^ (aString withoutQuoting) copyReplaceAll: '''''' with: ''''.
		
]

{ #category : #'generating-literals' }
MarvinParser >> symbolFromLiteral: aString [

	^ (self stringFromLiteral: aString allButFirst) asSymbol
		
]

{ #category : #generated }
MarvinParser >> symbolNames [
	^ #('"#("' '"."' '"<-"' '"="' '"|"' '"["' '"]"' '"("' '"}"' '"^"' '")"' '"{"' '<identifier>' '<parentSlotName>' '<keyword>' '<multikeyword>' '<argumentName>' '<binaryKeyword>' '<character>' '<number>' '<resend>' '<self>' '<string>' '<symbol>' '<comment>' '<whitespace>' 'BinarySlot' 'UnarySlot' 'KeywordNextParameters' 'KeywordSlotDeclaration' 'KeywordSlot' 'MethodObject' 'DataSlot' 'Slot' 'MethodSlot' 'SlotList' 'MethodSlotList' 'Slots' 'Block' 'RegularObject' 'Object' 'ExprSequence' '"."?' 'KeywordMessage' 'BinaryMessage' 'KeywordCapPart' 'KeywordCapPart*' 'ParentSlot' 'UnaryMessage' 'Expression' 'Primary' 'Literal' 'ParentSlotName' 'SlotName' 'B e g i n' 'Start' 'Array' 'BaseLiteral' 'ArrayLiteral' 'Code' 'ArraySymbol' 'E O F' 'error' 'MethodSlots' 'ArgumentSlot')
]

{ #category : #generated }
MarvinParser >> transitionTable [
^#(
#[1 0 9 0 1 0 13 0 4 0 17 0 5 0 21 0 6 0 25 0 8 0 29 0 10 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 81 0 42 0 81 0 44 0 89 0 45 0 93 0 49 0 81 0 50 0 93 0 51 0 93 0 52 0 109 0 56 0 93 0 58 0 117 0 60 0 121 0 64] 
#[1 0 6 0 1 0 6 0 8 0 6 0 11 0 6 0 13 0 6 0 15 0 6 0 16 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 24 0 125 0 57] 
#[1 0 9 0 1 0 21 0 6 0 25 0 8 0 33 0 13 0 45 0 19 0 49 0 20 0 129 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 133 0 49 0 133 0 51 0 133 0 52 0 133 0 58] 
#[1 0 10 0 2 0 10 0 5 0 157 0 13 0 141 0 17 0 149 0 33 0 149 0 35 0 153 0 37 0 157 0 54 0 149 0 65] 
#[1 0 9 0 1 0 13 0 4 0 17 0 5 0 21 0 6 0 165 0 7 0 25 0 8 0 29 0 10 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 81 0 42 0 81 0 44 0 89 0 45 0 93 0 49 0 81 0 50 0 93 0 51 0 93 0 52 0 93 0 58 0 169 0 60 0 173 0 64] 
#[1 0 9 0 1 0 13 0 4 0 177 0 5 0 21 0 6 0 25 0 8 0 181 0 11 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 185 0 38 0 77 0 39 0 77 0 40 0 77 0 41 0 189 0 44 0 89 0 45 0 93 0 49 0 189 0 50 0 93 0 51 0 93 0 52 0 93 0 58] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 193 0 44 0 89 0 45 0 93 0 49 0 193 0 50 0 93 0 51 0 93 0 52 0 93 0 58] 
#[0 0 14 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 41 0 18 0 45 0 19 0 49 0 20 0 197 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 201 0 45 0 93 0 49 0 93 0 51 0 93 0 52 0 93 0 58] 
#[1 0 9 0 1 0 21 0 6 0 25 0 8 0 33 0 13 0 45 0 19 0 49 0 20 0 129 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 205 0 49 0 205 0 51 0 205 0 52 0 205 0 58] 
#[0 0 18 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 22 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[1 0 209 0 4 0 213 0 13 0 217 0 15 0 221 0 18] 
#[0 0 26 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 30 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 34 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 38 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 38 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 42 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[1 0 225 0 2 0 46 0 7 0 46 0 9 0 229 0 43 0 46 0 62] 
#[0 0 50 0 2 0 5 0 7 0 9 0 11 0 62] 
#[1 0 54 0 2 0 233 0 4 0 54 0 5 0 54 0 7 0 54 0 9 0 54 0 11 0 237 0 15 0 241 0 18 0 54 0 62] 
#[1 0 58 0 2 0 58 0 4 0 58 0 5 0 58 0 7 0 58 0 9 0 58 0 11 0 245 0 13 0 58 0 15 0 58 0 18 0 58 0 62] 
#[0 0 62 0 2 0 7 0 9 0 62] 
#[0 0 66 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 70 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 0 0 62] 
#[0 0 74 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 78 0 62] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 29 0 10 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 81 0 42 0 81 0 44 0 89 0 45 0 93 0 49 0 81 0 50 0 93 0 51 0 93 0 52 0 93 0 58 0 249 0 60 0 78 0 62] 
#[1 0 253 0 1 1 1 0 8 1 5 0 11 1 9 0 13 1 13 0 15 1 17 0 16 1 21 0 18 1 25 0 19 1 29 0 20 1 33 0 21 1 37 0 22 1 41 0 23 1 45 0 24 1 49 0 40 1 53 0 59 1 53 0 61] 
#[0 0 213 0 13] 
#[1 0 82 0 2 0 82 0 4 0 82 0 5 0 82 0 7 0 82 0 9 0 82 0 11 0 245 0 13 0 82 0 15 0 82 0 18 0 82 0 62] 
#[0 0 86 0 2 0 3 0 4 0 5] 
#[0 0 90 0 2 0 5] 
#[0 0 94 0 2 0 5] 
#[0 0 98 0 2 0 5] 
#[1 1 61 0 2 1 65 0 5] 
#[1 0 102 0 2 1 69 0 3 1 73 0 4 0 102 0 5] 
#[0 0 94 0 2 0 5] 
#[0 0 106 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 1 77 0 7] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 1 81 0 7 0 25 0 8 0 29 0 10 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 81 0 42 0 81 0 44 0 89 0 45 0 93 0 49 0 81 0 50 0 93 0 51 0 93 0 52 0 93 0 58 1 85 0 60] 
#[1 0 110 0 2 1 89 0 4 0 110 0 5 1 141 0 13 1 137 0 14 1 97 0 15 1 101 0 18 1 125 0 27 1 125 0 28 1 113 0 30 1 125 0 31 1 125 0 33 1 125 0 34 1 129 0 36 1 125 0 48 1 137 0 53 1 141 0 54] 
#[0 0 114 0 1 0 2 0 4 0 5 0 7 0 8 0 9 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 62] 
#[0 1 145 0 11] 
#[0 1 149 0 11] 
#[1 1 153 0 2 0 46 0 7 0 46 0 9 1 157 0 43 0 46 0 62] 
#[1 0 209 0 4 0 213 0 13 0 221 0 18] 
#[1 0 118 0 2 0 233 0 4 0 118 0 5 0 118 0 7 0 118 0 9 0 118 0 11 0 118 0 15 0 241 0 18 1 161 0 47 0 118 0 62] 
#[1 0 82 0 2 0 82 0 4 0 82 0 5 0 82 0 7 0 82 0 9 0 82 0 11 0 245 0 13 0 82 0 15 0 82 0 18 0 82 0 62] 
#[1 0 9 0 1 0 21 0 6 0 25 0 8 0 33 0 13 0 45 0 19 0 49 0 20 0 129 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 165 0 49 1 165 0 51 1 165 0 52 1 165 0 58] 
#[0 0 122 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 41 0 18 0 45 0 19 0 49 0 20 0 197 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 169 0 45 0 93 0 49 0 93 0 51 0 93 0 52 0 93 0 58] 
#[1 0 9 0 1 0 21 0 6 0 25 0 8 0 33 0 13 0 45 0 19 0 49 0 20 0 129 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 173 0 49 1 173 0 51 1 173 0 52 1 173 0 58] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 126 0 7 0 25 0 8 0 126 0 9 1 177 0 10 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 181 0 44 0 89 0 45 0 93 0 49 1 181 0 50 0 93 0 51 0 93 0 52 0 93 0 58 0 126 0 62] 
#[0 0 130 0 7 0 9 0 62] 
#[1 0 9 0 1 0 21 0 6 0 25 0 8 0 33 0 13 0 45 0 19 0 49 0 20 0 129 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 185 0 49 1 185 0 51 1 185 0 52 1 185 0 58] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 41 0 18 0 45 0 19 0 49 0 20 0 197 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 189 0 45 0 93 0 49 0 93 0 51 0 93 0 52 0 93 0 58] 
#[1 0 9 0 1 0 21 0 6 0 25 0 8 0 33 0 13 0 45 0 19 0 49 0 20 0 129 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 193 0 49 1 193 0 51 1 193 0 52 1 193 0 58] 
#[0 0 134 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 138 0 62] 
#[1 0 6 0 1 0 6 0 8 0 6 0 11 0 6 0 13 0 6 0 15 0 6 0 16 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 22 0 6 0 23 0 6 0 24 1 197 0 57] 
#[1 0 177 0 5 0 181 0 11 0 185 0 38] 
#[0 0 142 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 146 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 146 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 146 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 146 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 150 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 154 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 146 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 146 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 158 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 162 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 166 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 170 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[0 0 174 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[1 1 201 0 5 0 157 0 13 0 141 0 17 1 205 0 33 1 205 0 35 0 157 0 54 1 205 0 65] 
#[0 0 178 0 1 0 4 0 6 0 7 0 8 0 9 0 10 0 13 0 15 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 62] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 209 0 44 0 89 0 45 0 93 0 49 1 209 0 50 0 93 0 51 0 93 0 52 0 93 0 58] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 1 213 0 44 0 89 0 45 0 93 0 49 1 213 0 50 0 93 0 51 0 93 0 52 0 93 0 58] 
#[0 0 182 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 186 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 1 217 0 7] 
#[0 1 221 0 13] 
#[0 0 190 0 2 0 3 0 4 0 5] 
#[0 1 225 0 13] 
#[0 1 229 0 13] 
#[0 0 194 0 2 0 5] 
#[0 0 194 0 2 0 5] 
#[0 1 233 0 4] 
#[0 0 194 0 2 0 5] 
#[0 0 194 0 2 0 5] 
#[0 0 198 0 2 0 5] 
#[1 1 237 0 2 1 241 0 5] 
#[0 0 194 0 2 0 5] 
#[1 0 202 0 2 1 245 0 3 1 249 0 4 0 202 0 5] 
#[1 0 102 0 2 1 69 0 3 1 253 0 4 0 102 0 5] 
#[0 0 206 0 1 0 2 0 4 0 5 0 7 0 8 0 9 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 62] 
#[0 0 210 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 0 126 0 7 0 9 0 62] 
#[0 0 214 0 7 0 9 0 62] 
#[1 0 218 0 2 0 218 0 5 0 218 0 7 0 218 0 9 0 218 0 11 2 1 0 15 2 5 0 46 0 218 0 62] 
#[1 0 222 0 2 0 222 0 4 0 222 0 5 0 222 0 7 0 222 0 9 0 222 0 11 0 245 0 13 0 222 0 15 0 222 0 18 0 222 0 62] 
#[1 0 118 0 2 0 233 0 4 0 118 0 5 0 118 0 7 0 118 0 9 0 118 0 11 0 118 0 15 0 241 0 18 2 9 0 47 0 118 0 62] 
#[1 0 222 0 2 0 222 0 4 0 222 0 5 0 222 0 7 0 222 0 9 0 222 0 11 0 245 0 13 0 222 0 15 0 222 0 18 0 222 0 62] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 2 13 0 44 0 89 0 45 0 93 0 49 2 13 0 50 0 93 0 51 0 93 0 52 0 93 0 58] 
#[0 0 226 0 2 0 7 0 9 0 62] 
#[1 0 230 0 2 0 230 0 4 0 230 0 5 0 230 0 7 0 230 0 9 0 230 0 11 0 245 0 13 0 230 0 15 0 230 0 18 0 230 0 62] 
#[1 0 118 0 2 0 233 0 4 0 118 0 5 0 118 0 7 0 118 0 9 0 118 0 11 0 118 0 15 0 241 0 18 2 17 0 47 0 118 0 62] 
#[1 0 230 0 2 0 230 0 4 0 230 0 5 0 230 0 7 0 230 0 9 0 230 0 11 0 245 0 13 0 230 0 15 0 230 0 18 0 230 0 62] 
#[1 0 253 0 1 1 1 0 8 2 21 0 11 1 9 0 13 1 13 0 15 1 17 0 16 1 21 0 18 1 25 0 19 1 29 0 20 1 33 0 21 1 37 0 22 1 41 0 23 1 45 0 24 1 49 0 40 1 53 0 59 1 53 0 61] 
#[0 0 234 0 1 0 4 0 6 0 7 0 8 0 9 0 10 0 13 0 15 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 62] 
#[0 0 238 0 2 0 5] 
#[0 0 242 0 2 0 5] 
#[0 0 242 0 2 0 5] 
#[0 0 246 0 2 0 4 0 5 0 7 0 9 0 11 0 13 0 15 0 18 0 62] 
#[0 2 25 0 4] 
#[1 0 250 0 4 2 29 0 15 2 33 0 29] 
#[0 2 37 0 4] 
#[1 2 41 0 12 2 45 0 32] 
#[1 1 89 0 4 2 49 0 5 1 141 0 13 1 137 0 14 1 97 0 15 1 101 0 18 2 53 0 27 2 53 0 28 1 113 0 30 2 53 0 31 2 53 0 33 2 53 0 34 2 53 0 48 1 137 0 53 1 141 0 54] 
#[0 0 254 0 11] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 2 57 0 44 0 89 0 45 0 93 0 49 2 57 0 50 0 93 0 51 0 93 0 52 0 93 0 58] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 2 61 0 44 0 89 0 45 0 93 0 49 2 61 0 50 0 93 0 51 0 93 0 52 0 93 0 58] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 2 41 0 12 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 2 65 0 32 0 77 0 39 0 77 0 40 0 77 0 41 1 213 0 44 0 89 0 45 0 93 0 49 1 213 0 50 0 93 0 51 0 93 0 52 0 93 0 58] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 0 33 0 13 0 41 0 18 0 45 0 19 0 49 0 20 0 197 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 2 69 0 45 0 93 0 49 0 93 0 51 0 93 0 52 0 93 0 58] 
#[0 1 2 0 2 0 5 0 7 0 9 0 11 0 15 0 62] 
#[1 1 6 0 2 1 6 0 5 1 6 0 7 1 6 0 9 1 6 0 11 2 1 0 15 2 5 0 46 1 6 0 62] 
#[1 1 153 0 2 0 46 0 7 0 46 0 9 2 73 0 43 0 46 0 62] 
#[1 1 10 0 2 1 10 0 5 1 10 0 7 1 10 0 9 1 10 0 11 2 1 0 15 2 5 0 46 1 10 0 62] 
#[0 1 14 0 1 0 8 0 11 0 13 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24] 
#[1 2 41 0 12 2 77 0 32] 
#[0 2 81 0 13] 
#[0 1 18 0 4] 
#[1 2 41 0 12 2 85 0 32] 
#[1 0 9 0 1 0 13 0 4 0 17 0 5 0 21 0 6 0 25 0 8 2 89 0 9 0 29 0 10 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 81 0 42 0 81 0 44 0 89 0 45 0 93 0 49 0 81 0 50 0 93 0 51 0 93 0 52 0 93 0 58 2 93 0 60 2 97 0 64] 
#[0 1 22 0 2 0 5] 
#[0 1 26 0 11] 
#[0 1 30 0 2 0 5] 
#[0 1 34 0 2 0 5] 
#[0 1 34 0 2 0 5] 
#[0 1 38 0 2 0 5] 
#[1 1 42 0 2 0 233 0 4 1 42 0 5 1 42 0 7 1 42 0 9 1 42 0 11 1 42 0 15 0 241 0 18 1 42 0 62] 
#[0 1 46 0 7 0 9 0 62] 
#[0 1 50 0 2 0 5] 
#[1 0 250 0 4 2 29 0 15 2 101 0 29] 
#[0 1 50 0 2 0 5] 
#[0 1 54 0 2 0 5] 
#[0 2 105 0 9] 
#[1 0 9 0 1 0 13 0 4 0 21 0 6 0 25 0 8 2 109 0 9 0 29 0 10 0 33 0 13 0 37 0 15 0 41 0 18 0 45 0 19 0 49 0 20 0 53 0 21 0 57 0 22 0 61 0 23 0 65 0 24 0 77 0 39 0 77 0 40 0 77 0 41 0 81 0 42 0 81 0 44 0 89 0 45 0 93 0 49 0 81 0 50 0 93 0 51 0 93 0 52 0 93 0 58 2 113 0 60] 
#[0 1 58 0 4] 
#[0 1 62 0 2 0 5] 
#[0 1 62 0 2 0 5] 
#[0 2 117 0 9] 
#[0 1 66 0 2 0 5]
	).
]

{ #category : #generating }
MarvinParser >> unarySlot: aCollection [

	| slot |
	
	slot := MarvinSlotLiteral new
			name: aCollection first value;
			type: #methodSlot.
			
	slot content: aCollection third.
	
	^ OrderedCollection with: slot.


]

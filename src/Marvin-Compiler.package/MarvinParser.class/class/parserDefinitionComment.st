generated-comments
parserDefinitionComment

	"Start :
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
|	ParentSlotName ""="" ""["" Expression ""]""								{ #parentSlot: }
|	ParentSlotName ""<-"" ""["" Expression ""]""								{ #parentSlot: }  
	;

DataSlot :
	SlotName														{ #dataSlot: } 
|	SlotName ""="" ""["" Expression ""]""										{ #dataSlot: }
|	SlotName ""<-"" ""["" Expression ""]""									{ #dataSlot: }  
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
	""("" "")""															{ #method: }
|	""("" MethodSlots "")"" 												{ #method: }
|	""("" Code "")"" 														{ #method: }
|	""("" MethodSlots Code "")"" 											{ #method: }
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
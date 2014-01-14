generated-comments
scannerDefinitionComment

	"<identifier> :
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
	
"
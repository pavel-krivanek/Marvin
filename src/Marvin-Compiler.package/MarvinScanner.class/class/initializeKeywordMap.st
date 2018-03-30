generated-initialization
initializeKeywordMap
	keywordMap := Dictionary new.
	#(#(16 '<-' 4) #(11 'resend' 19) #(11 'self' 20))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
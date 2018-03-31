generated-initialization
initializeKeywordMap
	keywordMap := Dictionary new.
	#(#(18 '<-' 3) #(13 'resend' 21) #(13 'self' 22))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
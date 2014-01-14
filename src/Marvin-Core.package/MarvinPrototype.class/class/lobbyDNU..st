as yet unclassified
lobbyDNU: aMessage

	 ^ Smalltalk at: aMessage selector 
		ifAbsent: [ 
			MessageNotUnderstood new 
				message: aMessage;
				receiver: self;
				signal.
			aMessage sentTo: self.]
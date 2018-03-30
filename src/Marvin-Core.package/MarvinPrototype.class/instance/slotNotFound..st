as yet unclassified
slotNotFound: aMessage

	MarvinSlotNotFound new 
		message: aMessage;
		receiver: self;
		signal.
	^ aMessage sentTo: self.
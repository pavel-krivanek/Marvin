slots
AddInheritance: slotName from: aBehavior

	self AddParentSlot: slotName value: aBehavior.
	self AllocateDataFor: aBehavior.

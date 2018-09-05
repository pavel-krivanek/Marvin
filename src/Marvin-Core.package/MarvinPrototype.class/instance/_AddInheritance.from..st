slots
_AddInheritance: slotName from: aBehavior

	self _AddParentSlot: slotName value: aBehavior.
	self _AllocateDataFor: aBehavior.

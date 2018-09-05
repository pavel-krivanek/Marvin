running
setUp

	super setUp.

	parent := MarvinPrototype new.
	object := MarvinPrototype new.
	object _AddParentSlot: #parent value: parent.

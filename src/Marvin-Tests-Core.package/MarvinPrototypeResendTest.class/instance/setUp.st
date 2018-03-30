running
setUp

	super setUp.

	parent := MarvinPrototype new.
	object := MarvinPrototype new.
	object AddParentSlot: #parent value: parent.

as yet unclassified
model: anObject 

	| resizingMorph |

	slotModel := anObject.

	editor := PluggableTextMorph
				on: (MarvinOtlSlotModel on: anObject)
					text: #getText
					accept: #setText:
					readSelection: nil
					menu: #codePaneMenu:shifted:.
	editor extent: 320 @ 120.
	editor color: Color white.

	resizingMorph := MarvinOtlResizingMorph new.
	resizingMorph position: (editor position x + editor width) 
				@ (editor position y + editor height).
	editor addMorph: resizingMorph.
	resizingMorph outlinerElement: self.

	self addElement: editor.

	self name: anObject name.
	self toggle: state.

	self menuAction: (MessageSend receiver: self selector: #yellowButtonMenu)
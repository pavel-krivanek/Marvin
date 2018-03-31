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
	editor color: (Color r: 0.995 g: 0.995 b: 0.941).

	resizingMorph := MarvinOtlResizingMorph new.
	resizingMorph position: (editor position x + editor width) 
				@ (editor position y + editor height).
	editor addMorph: resizingMorph.

	self addElement: editor.

	self name: anObject asString.
	self toggle: state.

	self menuAction: (MessageSend receiver: self selector: #yellowButtonMenu)
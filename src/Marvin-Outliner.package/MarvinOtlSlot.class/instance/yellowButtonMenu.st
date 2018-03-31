as yet unclassified
yellowButtonMenu

	| menu reply |

	menu := CustomMenu fromArray:
		#(	('add slot'		addSlot)
			-
			('rename'		renameSlot)
			('remove'		removeSlot)
			).
	reply := menu startUp.

	reply ifNil: [ ^ self ].

	
	
as yet unclassified
on: aModel

	| editor |

	editor := super on: aModel
		text: #getText
		accept: #setText:
		readSelection: nil
		menu: #codePaneMenu:shifted:.

	^ editor initializeFor: aModel

as yet unclassified
hideableSubmorphs

	^ self submorphs select:  [ :m | m ~= self title ]
accessing
standardLiterals: literalsCollection

	^ literalsCollection select: [ :lit | lit isBlockLiteral not ].
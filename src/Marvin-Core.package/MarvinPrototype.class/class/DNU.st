private
DNU

	"an Object used as method return value indicating failure in slot lookup"

	^ DNU ifNil: [ DNU := Object new ]
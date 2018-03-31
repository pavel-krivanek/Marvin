access
initialize

	super initialize.

	self borderColor: Color black.
	self sticky: false.

	handler := MarvinOtlConnectorHandler new.

	handler openInWorld..
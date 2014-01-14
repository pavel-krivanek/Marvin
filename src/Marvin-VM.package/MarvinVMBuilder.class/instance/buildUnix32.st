as yet unclassified
buildUnix32

	MarvinVMUnixConfig new
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		generateSources; generate.

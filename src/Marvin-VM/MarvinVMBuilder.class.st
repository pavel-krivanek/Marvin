"
MarvinVMBuilder buildOnJenkins: 'linux'. 

"
Class {
	#name : #MarvinVMBuilder,
	#superclass : #PharoSVMBuilder,
	#category : 'Marvin-VM'
}

{ #category : #'as yet unclassified' }
MarvinVMBuilder >> buildUnix32 [

	MarvinVMUnixConfig new
		addExternalPlugins: #( FT2Plugin SqueakSSLPlugin );
		addInternalPlugins: #( UnixOSProcessPlugin  );
		generateSources; generate.

]

"
The baseline to load Marvin - prototype based language based on Self
"
Class {
	#name : #BaselineOfMarvin,
	#superclass : #BaselineOf,
	#category : 'BaselineOfMarvin'
}

{ #category : #baselines }
BaselineOfMarvin >> baseline: spec [
   <baseline>
	spec for: #'common' do: [
		spec baseline: 'SmaCC' with: [
			spec repository: 'github://ThierryGoubier/SmaCC'].
		spec package: 'Marvin-Core'.
		spec package: 'Marvin-Tests-Core'.
		spec package: 'Marvin-Compiler' ].
		
]

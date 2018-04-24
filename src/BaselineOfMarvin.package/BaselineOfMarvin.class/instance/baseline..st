baselines
baseline: spec
   <baseline>
	spec for: #'common' do: [
		spec baseline: 'SmaCC' with: [
			spec repository: 'github://ThierryGoubier/SmaCC'].
		spec package: 'Marvin-Core'.
		spec package: 'Marvin-Tests-Core'.
		spec package: 'Marvin-Compiler' ].
		
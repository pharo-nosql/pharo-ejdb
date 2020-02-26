Class {
	#name : #BaselineOfEJDB,
	#superclass : #BaselineOf,
	#category : #BaselineOfEJDB
}

{ #category : #baselines }
BaselineOfEJDB >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec 
			package: 'EJDB';
			package: 'EJDB-Tests' ]
]

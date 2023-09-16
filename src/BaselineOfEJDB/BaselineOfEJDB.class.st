"
Baseline for [https://github.com/pharo-nosql/pharo-ejdb](https://github.com/pharo-nosql/pharo-ejdb)
"
Class {
	#name : #BaselineOfEJDB,
	#superclass : #BaselineOf,
	#category : #'BaselineOfEJDB-Base'
}

{ #category : #baselines }
BaselineOfEJDB >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		spec 
			package: 'EJDB';
			package: 'EJDB-Tests' with: [ spec requires: #('EJDB' ) ]]
]

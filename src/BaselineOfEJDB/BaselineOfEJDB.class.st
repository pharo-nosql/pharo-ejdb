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
		"Packages"	
		spec 
			package: 'EJDB';
			package: 'EJDB-Tests' with: [ spec requires: #('EJDB' ) ].
		
		"Groups"	
		spec 
			group: 'Core' with: #('EJDB' );
			group: 'Tests' with: #('EJDB-Tests');
			group: 'CI' with: #('Tests');			
			group: 'all' with: #('Core' 'Tests');
			group: 'default' with: #('all') ]
]

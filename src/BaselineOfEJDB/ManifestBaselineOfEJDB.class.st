"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBaselineOfEJDB,
	#superclass : #PackageManifest,
	#category : #'BaselineOfEJDB-Manifest'
}

{ #category : #'code-critics' }
ManifestBaselineOfEJDB class >> ruleClassNotReferencedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#BaselineOfEJDB)) #'2023-09-16T15:54:25.77682+02:00') )
]

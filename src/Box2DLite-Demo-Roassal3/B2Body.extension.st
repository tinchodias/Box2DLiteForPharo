Extension { #name : #B2Body }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Body >> addToRSComposite: aRSComposite [

	| box |
	box := RSBox new
		color: Color white;
		border: (RSBorder new width: 0.01; yourself);
		position: self position;
		rotateByDegrees: self rotation radiansToDegrees;
		extent: self extent;
		yourself.

	aRSComposite add: box.
]

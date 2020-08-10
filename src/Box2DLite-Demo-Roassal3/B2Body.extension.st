Extension { #name : #B2Body }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Body >> drawOnRSCanvas: aRSCanvas [

	| box |
	box := RSBox new.

	box color: Color white.
	box border: (RSBorder new width: 0.01; yourself).

	box position: self position;
		rotateByDegrees: self rotation radiansToDegrees;
		extent: self extent.

	aRSCanvas add: box.
]

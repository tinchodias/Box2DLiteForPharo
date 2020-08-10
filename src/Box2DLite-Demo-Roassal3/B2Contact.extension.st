Extension { #name : #B2Contact }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Contact >> drawOnRSCanvas: aRSCanvas [

	| ellipse |
	ellipse := RSEllipse new.
	ellipse
		color: Color red;
		position: self position;
		extent: 0.1 asPoint.

	aRSCanvas add: ellipse.
]

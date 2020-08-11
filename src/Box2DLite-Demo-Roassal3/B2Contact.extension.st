Extension { #name : #B2Contact }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Contact >> addToRSComposite: aRSComposite [

	| ellipse |
	ellipse := RSEllipse new
		color: Color red;
		position: self position;
		extent: 0.1 asPoint;
		yourself.

	aRSComposite add: ellipse.
]

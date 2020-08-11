Extension { #name : #B2Joint }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Joint >> addToRSComposite: aRSComposite [

	| b1 b2 x1 p1 x2 p2 line |
	b1 := self body1.
	b2 := self body2.
	x1 := b1 position.
	p1 := x1 + (b1 rotationMatrix * self localAnchor1).
	x2 := b2 position.
	p2 := x2 + (b2 rotationMatrix * self localAnchor2).
	
	line := RSPolyline new
		controlPoints: { p1. x2. p2 };
		width: 0.01;
		color: Color blue;
		yourself.
	
	aRSComposite add: line.

]

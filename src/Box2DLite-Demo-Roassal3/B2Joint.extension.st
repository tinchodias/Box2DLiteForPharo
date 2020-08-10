Extension { #name : #B2Joint }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Joint >> drawOnRSCanvas: aRSCanvas [

	| b1 b2 r1bis r2bis x1 p1 x2 p2 line |
	b1 := self body1.
	b2 := self body2.
	r1bis := B2Mat22 rotation: b1 rotation.
	r2bis := B2Mat22 rotation: b2 rotation.
	x1 := b1 position.
	p1 := x1 + (r1bis * self localAnchor1).
	x2 := b2 position.
	p2 := x2 + (r2bis * self localAnchor2).
	
	line := RSPolyline new
		controlPoints: { p1. x2. p2 };
		width: 0.01;
		color: Color blue;
		yourself.
	
	aRSCanvas add: line.

]

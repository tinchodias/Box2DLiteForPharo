Extension { #name : #RSBoundingShape }

{ #category : #'*Box2DLite-Demo-Roassal3' }
RSBoundingShape >> loadIdentity [
	matrix loadIdentity
]

{ #category : #'*Box2DLite-Demo-Roassal3' }
RSBoundingShape >> rotateByRadians: angle [
	"Rotate the shape. Here is an exanmple:
-=-=-=
c := RSCanvas new.

box := RSBox new.
box rotateByRadians: Float halfPi.

c add: polygon.
c	
-=-=-=
	"
	matrix rotateByRadians: angle
]

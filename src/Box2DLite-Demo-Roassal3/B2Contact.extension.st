Extension { #name : #B2Contact }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Contact >> asRSShape [
	^ RSEllipse new
		  color: Color red;
		  extent: 0.1 asPoint;
		  yourself
]

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Contact >> updateRSShape: aRSShape [
	aRSShape position: self position
]

Extension { #name : #B2Body }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Body >> asRSShape [
	^ RSBox new
		  color: Color white;
		  border: (RSBorder new
				   width: 0.01;
				   yourself);
		  yourself
]

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Body >> updateRSShape: aRSShape [
	aRSShape
		loadIdentity;
		position: self position;
		rotateByRadians: self rotation;
		extent: self extent
]

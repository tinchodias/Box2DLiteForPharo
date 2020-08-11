Extension { #name : #Rectangle }

{ #category : #'*Box2DLite-Demo-Roassal3' }
Rectangle >> flipped [
	^ self origin * -1 corner: self corner * -1
]

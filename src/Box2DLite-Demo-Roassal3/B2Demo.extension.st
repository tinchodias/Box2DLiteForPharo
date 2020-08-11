Extension { #name : #B2Demo }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Demo >> openWithRoassal3 [
	| presenter |
	presenter := RSB2SpFrame new.
	presenter openWithSpec.
	^ presenter
]

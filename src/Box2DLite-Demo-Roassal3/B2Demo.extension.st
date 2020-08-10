Extension { #name : #B2Demo }

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Demo >> drawOnRSCanvas: aRSCanvas [
	| aRSComposite |
	aRSCanvas shapes copy do: #remove.
	
	aRSComposite := RSComposite new
		scaleBy: (1 @ -1);
		yourself.
	
	aRSCanvas add: aRSComposite.
	(world bodies, world joints, world contacts)
		do: [ :each | each drawOnRSCanvas: aRSComposite ].

]

{ #category : #'*Box2DLite-Demo-Roassal3' }
B2Demo >> openWithRoassal3 [
	| presenter |
	presenter := RSB2SpFrame new.
	presenter openWithSpec.
	presenter window title: self class name.
	^ presenter
]

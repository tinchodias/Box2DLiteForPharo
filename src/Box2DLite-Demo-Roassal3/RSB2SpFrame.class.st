Class {
	#name : #RSB2SpFrame,
	#superclass : #SpPresenter,
	#instVars : [
		'stage',
		'demos',
		'display',
		'buttonAccumulateImpulses',
		'buttonWarmStarting',
		'buttonPositionCorrection'
	],
	#category : #'Box2DLite-Demo-Roassal3'
}

{ #category : #specs }
RSB2SpFrame class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #demos withConstraints: [ :c | c width: 100 ];
		add:
			(SpBoxLayout newVertical
				add:
					(SpBoxLayout newHorizontal
						add: #buttonAccumulateImpulses;
						add: #buttonPositionCorrection;
						add: #buttonWarmStarting;
						yourself)
					withConstraints: [ :c | c height: 30 ];
				add: #stage;
				yourself);
		yourself
]

{ #category : #private }
RSB2SpFrame class >> stageExtent [
	^ 800 @ 800
]

{ #category : #initialization }
RSB2SpFrame >> connectPresenters [
	demos
		display: [ :each | each asString ];
		whenSelectionChangedDo: [ :each | stage refresh ].
	buttonAccumulateImpulses
		whenActivatedDo: [ B2World accumulateImpulses: true ];
		whenDeactivatedDo: [ B2World accumulateImpulses: false ].
	buttonPositionCorrection
		whenActivatedDo: [ B2World positionCorrection: true ];
		whenDeactivatedDo: [ B2World positionCorrection: false ].
	buttonWarmStarting
		whenActivatedDo: [ B2World warmStarting: true ];
		whenDeactivatedDo: [ B2World warmStarting: false ]
]

{ #category : #private }
RSB2SpFrame >> demoClasses [
	^ B2Demo subclasses
]

{ #category : #initialization }
RSB2SpFrame >> initializeCanvas: canvas [
		
	| container demo highlightable popup |
	demo := demos selection selectedItem
		ifNil: [ ^ self ]
		ifNotNil: [ :demoClass | demoClass new ].

	demo restart.

	container := RSComposite new
		scaleBy: (1 @ -1);
		yourself.
	canvas add: container.

	canvas addInteraction: RSGraphCanvasMonitor. 
	canvas addInteraction: RSZoomableCanvas.
	canvas when: RSMouseLeftClick send: #inspect to: demo world.
"	canvas when: RSMouseRightClick send: #launchBomb to: demo."
	canvas when: RSMouseRightClick send: #launchManyBombs to: demo.

	highlightable := RSHighlightable new highlightColor: Color blue translucent; yourself.
	popup := RSPopup new.

	"Set RSCanvas' camera with viewport (whose coordinates must be flipped)"
	canvas camera 
		zoomToFit: canvas extent
		rectangle: demo viewport flipped.
	
	canvas newAnimation repeat onStepDo: [ :t |
		| currentWorldObjects |
		demo step.
		
		currentWorldObjects := demo world bodies, demo world joints, demo world contacts.
		
		container shapes copy
			reject: [ :each | currentWorldObjects includes: each model ]
			thenDo: [ :each | each remove ].
		
		currentWorldObjects do: [ :each |
			|shape|
			shape := container shapes shapeFromModel: each.
			shape ifNil: [
				shape := each asRSShape
					model: each;
					addInteraction: highlightable;
					addInteraction: popup;
					when: RSMouseLeftClick send: #inspect to: each;
					yourself.
				container add: shape ].
			each updateRSShape: shape.
		].

		canvas signalUpdate ].

]

{ #category : #initialization }
RSB2SpFrame >> initializePresenters [
	buttonAccumulateImpulses := self newCheckBox.
	buttonAccumulateImpulses
		label: 'accumulate impulses';
		state: B2World accumulateImpulses.

	buttonWarmStarting := self newCheckBox.
	buttonWarmStarting
		label: 'warm starting';
		state: B2World warmStarting.

	buttonPositionCorrection := self newCheckBox.
	buttonPositionCorrection
		label: 'position correction';
		state: B2World positionCorrection.

	demos := self newList.
	demos beSingleSelection.
	demos items: self demoClasses.

	stage := self instantiate: SpRoassalPresenter.
	stage script: [ :canvas |
		self initializeCanvas: canvas ].

	self focusOrder
		add: demos;
		add: stage
]

{ #category : #initialization }
RSB2SpFrame >> initializeWindow: aWindow [
	aWindow
		title: 'Box2DLite on Roassal3';
		initialExtent: self class stageExtent + (120 @ 70)
]

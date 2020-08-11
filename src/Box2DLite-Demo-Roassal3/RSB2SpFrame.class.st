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
		whenSelectionChangedDo: [ :each | self setupDemo: each ].
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

{ #category : #private }
RSB2SpFrame >> setupDemo: aSelection [
	| demo canvas flippedComposite |
	demo := aSelection selectedItem new.
	demo restart.

	"Clear canvas (may have shapes from previous selected demo"
	canvas := stage canvas.
	canvas shapes copy do: #remove.
	flippedComposite := RSComposite new
		scaleBy: (1 @ -1);
		yourself.
	canvas add: flippedComposite.

	self flag: #fix. "Adding new interactions without cleaning old ones before."
	canvas addInteraction: RSGraphCanvasMonitor. 
	canvas when: RSMouseLeftClick send: #launchBomb to: demo.
	canvas when: RSMouseRightClick send: #launchManyBombs to: demo.

	"Set RSCanvas' camera with viewport (whose coordinates must be flipped)"
	canvas camera 
		zoomToFit: canvas extent
		rectangle: demo viewport flipped.
		
	canvas newAnimation repeat onStepDo: [ :t |
		flippedComposite shapes copy do: #remove.
		demo step.
		(demo world bodies, demo world joints, demo world contacts)
			do: [ :each | each addToRSComposite: flippedComposite ].
		canvas signalUpdate ].

]

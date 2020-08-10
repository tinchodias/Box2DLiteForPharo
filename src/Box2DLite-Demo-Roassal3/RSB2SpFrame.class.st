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
	self initializeStage.

	self focusOrder
		add: demos;
		add: stage
]

{ #category : #initialization }
RSB2SpFrame >> initializeStage [
"	| morph |
	1halt."
"	display := B2Display extent: self class stageExtent.
	morph := B2DemoMorph new.
	morph display: display.
	stage morph: morph"
]

{ #category : #initialization }
RSB2SpFrame >> initializeWindow: aWindow [
	aWindow initialExtent: self class stageExtent + (120 @ 70)
]

{ #category : #private }
RSB2SpFrame >> setupDemo: aSelection [
	| demo canvas rect |
	demo := aSelection selectedItem new.
	canvas := stage canvas.
	
	rect := demo viewport.
	
	canvas camera 
		zoomToFit: canvas extent
		rectangle: ((rect origin * -1) corner: (rect corner * -1)).
	demo restart.

	canvas addInteraction: RSGraphCanvasMonitor. 
	
	canvas when: RSMouseClick send: #launchBomb to: demo.
	
	canvas newAnimation repeat onStepDo: [ :t |
		demo step.
		demo drawOnRSCanvas: canvas.
		canvas signalUpdate ].

]

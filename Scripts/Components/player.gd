extends CharacterBody2D

class_name Player

@onready var playerSprite = $AnimatedSprite2D
@onready var interactArea = $InteractArea
@onready var dialogueBox = $DialogueBox
@onready var interactSign = $Panel
@onready var animationEventTimer = $AnimationEventTimer

var playerKey = "player"

const WalkSpeed = 300.0
const RunSpeed = 500.0

var interactableRef:Interactable = null
var onDialogue = false

func _ready() -> void:
	interactSign.visible = false

func _physics_process(delta: float) -> void:
	if onDialogue:
		velocity.x = 0
		return
	
	VerticalMovement(delta)
	HorizontalMovement()

	move_and_slide()

func _process(delta: float) -> void:
	flipPlayer()
	animatePlayer()

func flipPlayer():
	if velocity.x < 0:
		playerSprite.flip_h = true
	elif velocity.x > 0:
		playerSprite.flip_h = false

func animatePlayer():
	if onDialogue:
		return
	
	var movementAnimation = "Run" if Input.is_action_pressed("Run") else "Walk"
	
	if abs(velocity.x) > 0:
		playerSprite.play(movementAnimation)
	else:
		playerSprite.play("Idle")

func VerticalMovement(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func HorizontalMovement():
	var direction := Input.get_axis("Left", "Right")
	var curSpeed = RunSpeed if Input.is_action_pressed("Run") else WalkSpeed
	
	if direction:
		velocity.x = direction * curSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, curSpeed)

func checkDialogueInput():
	if !onDialogue:
		startDialogue()
	else:
		advanceSpeechDialogue()

func startDialogue():
	interactSign.visible = false
	playerSprite.play("Idle")
	DialogueManager.setNewDialogue(interactableRef.InteractDialogue)
	setDialogue()

func setDialogue():
	#Se é um texto, animação ou os cacete
	var event:DialogueEvents = DialogueManager.getDialogueEvent()
	if event == null:
		endDialogue()
		return
	
	if event is SpeechEvent:
		setSpeechDialogue(event)
	elif event is AnimationEvent:
		setAnimationDialogue(event)

func setSpeechDialogue(event:SpeechEvent):
	if event.entityKey != playerKey:
		#Play Event on another object
		return
	
	if !onDialogue:
		onDialogue = true
		dialogueBox.startDialogue()
	
	dialogueBox.setText(event.message)

func setAnimationDialogue(event:AnimationEvent):
	#Close dialogue Box
	dialogueBox.endDialogue()
	
	#SetTimer
	var time = event.animationTime
	
	if event.animationTime == 0:
		var frame_count = playerSprite.sprite_frames.get_frame_count(event.animationStr)
		var fps = playerSprite.sprite_frames.get_animation_speed(event.animationStr)
		var speed_scale = playerSprite.speed_scale
		time = (frame_count / fps) / speed_scale
	
	animationEventTimer.wait_time = time
	animationEventTimer.start()
	
	#PlayEvent on other object if the key is diferent
	if event.entityKey != playerKey:
		#Play Event on another object
		return
	
	#PLAY EVENT
	
	if !onDialogue:
		onDialogue = true
	
	#AnimatePlayer
	playerSprite.play(event.animationStr)
	playerSprite.flip_h = event.flipSprite
	
	#TweenPos
	if event.newPos == Vector2(0, 0):
		return
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", event.newPos, time)

func endDialogue():
	if dialogueBox.visible:
		dialogueBox.endDialogue()
	
	if interactableRef.deleteAfter:
		interactableRef.queue_free()
	
	for area in interactArea.get_overlapping_areas():
		if area is Interactable:
			interactSign.visible = true
			interactableRef = area
	
	onDialogue = false

func canAdvanceSpeechDialogue() -> bool:
	var event:DialogueEvents = DialogueManager.getDialogueEvent()
	
	if event is SpeechEvent:
		return true
	
	return false

func advanceSpeechDialogue():
	if !canAdvanceSpeechDialogue():
		return
	
	if !dialogueBox.isComplete():
		dialogueBox.completeDialogue()
		return
	
	advanceDialogue()

func advanceDialogue():
	DialogueManager.advanceDialogue()
	setDialogue()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") and interactableRef != null:
		checkDialogueInput()

func _on_interact_area_area_entered(area: Area2D) -> void:
	if area is Interactable and !onDialogue:
		interactableRef = area
		interactSign.visible = true
		
		if area.autoTrigger: 
			startDialogue()

func _on_interact_area_area_exited(area: Area2D) -> void:
	if area is Interactable and !onDialogue:
		interactableRef = null
		interactSign.visible = false

func _on_animation_event_timer_timeout() -> void:
	advanceDialogue()

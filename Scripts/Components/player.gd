extends CharacterBody2D

class_name Player

@onready var playerSprite = $AnimatedSprite2D
@onready var dialogueBox = $DialogueBox
@onready var interactSign = $Panel

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
		advanceDialogue()

func startDialogue():
	interactSign.visible = false
	
	DialogueManager.setNewDialogue(interactableRef.InteractDialogue)
	onDialogue = true
	dialogueBox.startDialogue()

func advanceDialogue():
	if !dialogueBox.isComplete():
		dialogueBox.completeDialogue()
		return
	
	DialogueManager.advanceDialogue()
	dialogueBox.setText()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") and interactableRef != null:
		checkDialogueInput()

func _on_interact_area_area_entered(area: Area2D) -> void:
	if area is Interactable:
		interactableRef = area
		interactSign.visible = true
		
		if area.autoTrigger: 
			startDialogue()

func _on_interact_area_area_exited(area: Area2D) -> void:
	if area is Interactable:
		interactableRef = null
		interactSign.visible = false

func _on_dialogue_box_dialogue_ended() -> void:
	onDialogue = false
	
	if interactableRef == null:
		return
	
	if interactableRef.deleteAfter:
		interactableRef.queue_free()
		interactSign.visible = false
	else:
		interactSign.visible = true

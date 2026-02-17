extends CharacterBody2D

@onready var playerSprite = $AnimatedSprite2D

const WalkSpeed = 300.0
const RunSpeed = 500.0

func _physics_process(delta: float) -> void:
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

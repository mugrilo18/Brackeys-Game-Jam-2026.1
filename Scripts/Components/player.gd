extends CharacterBody2D

@onready var playerSprite = $AnimatedSprite2D

const WalkSpeed = 300.0
const RunSpeed = 500.0

func _physics_process(delta: float) -> void:
	VerticalMovement(delta)
	HorizontalMovement()

	move_and_slide()

func _process(delta: float) -> void:
	if velocity.x < 0:
		playerSprite.flip_h = true
	elif velocity.x > 0:
		playerSprite.flip_h = false

func VerticalMovement(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func HorizontalMovement():
	var direction := Input.get_axis("ui_left", "ui_right") #Change to custom action later
	var curSpeed = RunSpeed if Input.is_physical_key_pressed(KEY_SHIFT) else WalkSpeed #Change to custom action later
	
	if direction:
		velocity.x = direction * curSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, curSpeed)

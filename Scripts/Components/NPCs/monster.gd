extends CharacterBody2D

class_name Monster

@onready var sprite = $AnimatedSprite2D
@onready var rayRight = $RaycastRight
@onready var rayLeft = $RaycastLeft

@onready var npcEvent = $NpcEvent

const SPEED = 480.0
var direction = 1.0

@export var isActive = true

var gameOver = false

var cutsceneChasePlayer = false
var chasePlayer = false
var playerRef:Player

signal eventDone

func _ready() -> void:
	setActive(isActive)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move()
	setDir()
	
	move_and_slide()

func getNPCKey():
	return npcEvent.npcKey

func playNPCEvent(event:DialogueEvents):
	visible = true
	npcEvent.setEvent(event)

func _process(delta: float) -> void:
	if isActive:
		sprite.play("Idle")
	
	sprite.flip_h = velocity.x < 0
	
	if playerRef != null and playerRef.isHiding:
		playerRef = null
		chasePlayer = false

func setDir():
	if (chasePlayer or cutsceneChasePlayer):
		direction = global_position.direction_to(playerRef.global_position).x
		return
	
	if rayRight.is_colliding():
		direction = -1.0
	elif rayLeft.is_colliding():
		direction = 1.0

func move():
	if !isActive:
		return
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func setActive(active:bool):
	isActive = active
	visible = active

func setChasePlayer(player:Player):
	cutsceneChasePlayer = true
	playerRef = player

func _on_animated_sprite_2d_animation_changed() -> void:
	if sprite.animation == "Appear":
		var stream:AudioStream = load("res://Assets/Audio/Game/MonsterAppear.wav")
		AudioSettings.setNewMusic(stream, 1.0)


func _on_chase_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") and !cutsceneChasePlayer and isActive and !gameOver:
		playerRef = area.get_parent()
		
		if playerRef.isHiding:
			return
		
		chasePlayer = true
		
		var stream = load("res://Assets/Audio/Game/MonsterChase.wav")
		AudioSettings.setNewMusic(stream, 0.01)

func _on_chase_player_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player") and !cutsceneChasePlayer and isActive and !gameOver:
		playerRef = null
		chasePlayer = false

func _on_game_over_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") and isActive and !gameOver:
		playerRef = area.get_parent()
		
		if playerRef.isHiding:
			return
		
		gameOver = true
		
		AudioSettings.stopMusic()
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/gameOver.tscn")

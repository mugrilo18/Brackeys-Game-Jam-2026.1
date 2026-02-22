extends Node2D

@export var stage:Stage

@export var tutorial_move: Label
@export var tutorial_interact: Label
@export var tutorial_sprint:Label
@export var playerBlockDialogue:Interactable

@export var monster:Monster

func _ready() -> void:
	tutorial_move.visible = false
	tutorial_interact.visible = false
	tutorial_sprint.visible = false

func _on_interactable_template_interacted_triggered() -> void:
	tutorial_move.visible = true
	tutorial_interact.visible = true

func _on_car_started_interaction() -> void:
	tutorial_move.visible = false
	tutorial_interact.visible = false

func _on_car_interacted_triggered() -> void:
	playerBlockDialogue.queue_free()
	tutorial_sprint.visible = true
	monster.setActive(true)
	monster.setChasePlayer(stage.playerRef)
	
	var stream = load("res://Assets/Audio/Game/MonsterChase.wav")
	AudioSettings.setNewMusic(stream, 0.0)

extends Node2D

@export var tutorial_move: Label
@export var tutorial_interact: Label

func _ready() -> void:
	tutorial_move.visible = false
	tutorial_interact.visible = false

func _on_interactable_template_interacted_triggered() -> void:
	tutorial_move.visible = true
	tutorial_interact.visible = true

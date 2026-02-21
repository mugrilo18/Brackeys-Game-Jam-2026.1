extends Node2D

func _ready() -> void:
	$Label.visible = false
	$Label2.visible = false

func _on_interactable_template_interacted_triggered() -> void:
	$Label.visible = true
	$Label2.visible = true

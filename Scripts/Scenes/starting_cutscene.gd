extends Node2D

@onready var skipCutscene = $CanvasLayer/Label
@onready var skipCutsceneTimer = $CanvasLayer/Appear

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		return
	
	if Input.is_action_just_pressed("Interact") and skipCutscene.visible:
		goToFirstStage()
	
	skipCutscene.visible = true
	skipCutsceneTimer.start()

func goToFirstStage():
	Transition.transitionToScene("res://Scenes/main.tscn")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	goToFirstStage()

func _on_appear_timeout() -> void:
	skipCutscene.visible = false

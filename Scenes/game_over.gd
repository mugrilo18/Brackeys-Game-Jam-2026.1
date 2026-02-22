extends Node2D

@onready var animationPlayer = $AnimationPlayer

@onready var skipCutscene = $CanvasLayer/Label
@onready var skipCutsceneTimer = $CanvasLayer/Appear

var skipped = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouse or !animationPlayer.is_playing() or skipped:
		return
	
	if Input.is_action_just_pressed("Interact") and skipCutscene.visible:
		skipMonster()
		return
	
	skipCutscene.visible = true
	skipCutsceneTimer.start()

func skipMonster():
	animationPlayer.seek(10.5)
	skipped = true
	skipCutscene.visible = false

func _on_appear_timeout() -> void:
	skipCutscene.visible = false

func _on_restart_button_down() -> void:
	Transition.transitionToScene("res://Scenes/main.tscn")

func _on_main_menu_button_down() -> void:
	Transition.transitionToScene("res://Scenes/main_menu.tscn")

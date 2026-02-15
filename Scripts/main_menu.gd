extends Control

@export var play_btn: Button
@export var quit_btn: Button
@export var options_btn: Button

func _ready() -> void:
	quit_btn.pressed.connect(QuitGame)
	play_btn.pressed.connect(PlayGame)
	
	Audio.playMusic()
	
	if OS.has_feature("web"):
		quit_btn.visible = false


func PlayGame():
	Audio.stopMusic()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	

func QuitGame():
	get_tree().quit()

extends Control

@export var play_btn: Button
@export var quit_btn: Button
@export var options_btn: Button

func _ready() -> void:
	quit_btn.pressed.connect(QuitGame)
	play_btn.pressed.connect(PlayGame)
	options_btn.pressed.connect(Settings)
	
	Audio.playMusic()
	
	if OS.has_feature("web"):
		quit_btn.visible = false


func PlayGame():
	Audio.stopMusic()
	Transition.transitionToScene("res://Scenes/starting_cutscene.tscn")

func QuitGame():
	get_tree().quit()

func Settings():
	%OptionsScreen.visible = true
	

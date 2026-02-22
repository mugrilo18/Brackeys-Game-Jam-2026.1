extends Control

@export var play_btn: Button
@export var quit_btn: Button
@export var options_btn: Button

func _ready() -> void:
	quit_btn.pressed.connect(QuitGame)
	play_btn.pressed.connect(PlayGame)
	options_btn.pressed.connect(Settings)
	
	var stream = load("res://Assets/Audio/Game/Forest.wav")
	AudioSettings.setNewMusic(stream)
	
	if OS.has_feature("web"):
		quit_btn.visible = false


func PlayGame():
	AudioSettings.stopMusic()
	Transition.transitionToScene("res://Scenes/starting_cutscene.tscn")

func QuitGame():
	get_tree().quit()

func Settings():
	%OptionsScreen.visible = true
	

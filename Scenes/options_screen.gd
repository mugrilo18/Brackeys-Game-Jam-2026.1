extends Control

@export var master_slider: HSlider
@export var music_slider: HSlider
@export var sfx_slider: HSlider

@export var master_percent: Label
@export var music_percent: Label
@export var sfx_percent: Label

@onready var fullscreen_btn: CheckButton = %FullscreenBtn
@onready var options_screen: Panel = $"."

@onready var screenSettings1 = $Settings/HSeparator2
@onready var screenSettings2 = $Settings/ScreenSettings
@onready var screenSettings3 = $"Settings/Screen Settings"

func _ready() -> void:
	master_percent.text = str(roundi(Audio.volumeMaster*100)) + "%"
	music_percent.text = str(roundi(Audio.volumeMusic*100)) + "%"
	sfx_percent.text = str(roundi(Audio.volumeSFX*100)) + "%"
	
	master_slider.value = Audio.volumeMaster
	music_slider.value = Audio.volumeMusic
	sfx_slider.value = Audio.volumeSFX
	
	options_screen.visible = false
	
	if OS.has_feature("web"):
		screenSettings1.visible = false
		screenSettings2.visible = false
		screenSettings3.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if options_screen.visible == false:
			options_screen.visible = true
			get_tree().paused = true
		

func _on_music_slider_value_changed(value: float) -> void:
	Audio.AudioMusic(value)
	music_percent.text = str(roundi(value*100)) + "%"

func _on_sfx_slider_value_changed(value: float) -> void:
	Audio.AudioSfx(value)
	sfx_percent.text = str(roundi(value*100)) + "%"

func _on_master_slider_value_changed(value: float) -> void:
	Audio.AudioMaster(value)
	master_percent.text = str(roundi(value*100)) + "%"

func _on_fullscreen_btn_toggled(toggled_on: bool) -> void:
	if toggled_on == true and ScreenSettings.is_fullscreen == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		ScreenSettings.is_fullscreen = true
	else:
		ScreenSettings.is_fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_confirm_btn_button_down() -> void:
	options_screen.visible = false
	get_tree().paused = false

func _on_back_menu_btn_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	

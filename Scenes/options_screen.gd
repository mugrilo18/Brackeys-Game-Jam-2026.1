extends Control

@export var master_slider: HSlider
@export var music_slider: HSlider
@export var sfx_slider: HSlider

@export var master_percent: Label
@export var music_percent: Label
@export var sfx_percent: Label

func _ready() -> void:
	master_percent.text = str(roundi(Audio.volumeMaster*100)) + "%"
	music_percent.text = str(roundi(Audio.volumeMusic*100)) + "%"
	sfx_percent.text = str(roundi(Audio.volumeSFX*100)) + "%"
	
	master_slider.value = Audio.volumeMaster
	music_slider.value = Audio.volumeMusic
	sfx_slider.value = Audio.volumeSFX

func _on_music_slider_value_changed(value: float) -> void:
	Audio.AudioMusic(value)
	music_percent.text = str(roundi(value*100)) + "%"

func _on_sfx_slider_value_changed(value: float) -> void:
	Audio.AudioSfx(value)
	sfx_percent.text = str(roundi(value*100)) + "%"

func _on_master_slider_value_changed(value: float) -> void:
	Audio.AudioMaster(value)
	master_percent.text = str(roundi(value*100)) + "%"

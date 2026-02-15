extends Node

@onready var uiAccept := AudioStreamPlayer.new()
@onready var uiCancel := AudioStreamPlayer.new()
@onready var musicPlayer := AudioStreamPlayer.new()

@onready var soundAccept = load("res://Assets/Audio/UIAccept.mp3")
@onready var soundCancel = load("res://Assets/Audio/UICancel.mp3")
@onready var musicStream = load("res://Assets/Audio/Menu.mp3")

var volumeMaster = 1.0
var volumeMusic = 1.0
var volumeSFX = 1.0
var curMusicPos = 0

const MASTER_AUDIO_NAME:String = "Master"
const MUSIC_AUDIO_NAME:String = "Music"
const SFX_AUDIO_NAME:String = "SFX"

var MASTER_AUDIO_ID
var MUSIC_AUDIO_ID
var SFX_AUDIO_ID
var Decibels

func _ready() -> void:
	MASTER_AUDIO_ID = AudioServer.get_bus_index(MASTER_AUDIO_NAME)
	MUSIC_AUDIO_ID = AudioServer.get_bus_index(MUSIC_AUDIO_NAME)
	SFX_AUDIO_ID = AudioServer.get_bus_index(SFX_AUDIO_NAME)
	
	add_child(uiAccept)
	add_child(uiCancel)
	add_child(musicPlayer)
	
	uiAccept.bus = SFX_AUDIO_NAME
	uiCancel.bus = SFX_AUDIO_NAME
	musicPlayer.bus = MUSIC_AUDIO_NAME
	
	musicPlayer.stream = musicStream

func playMusic():
	if musicPlayer.playing:
		return
	
	var audioTween = get_tree().create_tween()
	audioTween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	musicPlayer.volume_db = -80.0
	musicPlayer.play(curMusicPos)
	audioTween.tween_property(musicPlayer, "volume_db", 0.0, 2.0)

func stopMusic():
	curMusicPos = musicPlayer.get_playback_position()
	
	var audioTween = get_tree().create_tween()
	audioTween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	musicPlayer.volume_db = 0.0
	audioTween.tween_property(musicPlayer, "volume_db", -80.0, 2.0)
	audioTween.finished.connect(musicPlayer.stop)

func AudioMaster(value:float):
	volumeMaster = value
	Decibels = linear_to_db(value)
	AudioServer.set_bus_volume_db(MASTER_AUDIO_ID, Decibels)

func AudioMusic(value:float):
	volumeMusic = value
	Decibels = linear_to_db(value)
	AudioServer.set_bus_volume_db(MUSIC_AUDIO_ID, Decibels)

func AudioSfx(value:float):
	volumeSFX = value
	Decibels = linear_to_db(value)
	AudioServer.set_bus_volume_db(SFX_AUDIO_ID, Decibels)

func playUIAccept(audioDb = 0.0):
	uiAccept.stream = soundAccept
	var randomPitch = randf_range(0.8, 1.2)
	uiAccept.pitch_scale = randomPitch
	uiAccept.volume_db = audioDb
	uiAccept.play()

func playUICancel():
	uiCancel.stream = soundCancel
	uiCancel.play()

extends Node2D

@onready var player = $Player

@export_file("*.tscn") var startingStage:String
var curStage:Stage

func _ready() -> void:
	loadStage(startingStage)

func removeStage():
	if curStage == null:
		return
	
	curStage.queue_free()

func loadStage(stagePath:String):
	if stagePath == "" or stagePath == null:
		print("stage is invalid")
		return
	
	var stageLoad = load(stagePath)
	var stageInstance = stageLoad.instantiate()
	add_child(stageInstance)
	curStage = stageInstance
	
	setPlayerPosition()

func setPlayerPosition():
	player.global_position = curStage.GetPlayerPos()

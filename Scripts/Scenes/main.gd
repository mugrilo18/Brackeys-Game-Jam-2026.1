extends Node2D

class_name MainGame

@onready var player = $Player

#UI
@onready var inventoryUI = $CanvasLayer/ItemMenuBar

@export_file("*.tscn") var startingStage:String
var curStage:Stage

var newSpawnID:int

func _ready() -> void:
	if PlayerData.lastStagePath == "":
		loadStage(startingStage)
	else:
		loadStage(PlayerData.lastStagePath)

#STAGE LOGIC
func transitionStage(stagePath:String, spawnID:int):
	newSpawnID = spawnID
	removeStage()
	call_deferred("loadStage", stagePath)
	Transition.playFadeOut()

func removeStage():
	if curStage == null:
		return
	
	curStage.queue_free()

func loadStage(stagePath:String):
	if stagePath == "" or stagePath == null:
		print("stage is invalid")
		return
	
	var stageLoad = load(stagePath)
	var stageInstance:Stage = stageLoad.instantiate()
	add_child(stageInstance)
	
	curStage = stageInstance
	curStage.z_index = -1
	curStage.getPlayer(player)
	curStage.getGame(self)
	
	setPlayerPosition()
	PlayerData.lastStagePath = stagePath

func setPlayerPosition():
	player.global_position = curStage.GetPlayerPos(newSpawnID)

#INVENTORY LOGIC
func updateInventoryUI():
	inventoryUI.updateItems()

func getSelectedItem():
	return inventoryUI.getSelectedItem()

func openInventoryUI():
	inventoryUI.setBoxActive()

func closeInventoryUI():
	inventoryUI.setBoxInactive()

#NPC LOGIC
func playNPCEvent(event:DialogueEvents):
	curStage.playNPCEvent(event)

extends Node2D

class_name MainGame

@onready var player = $Player

#UI
@onready var inventoryUI = $CanvasLayer/ItemMenuBar

@export_file("*.tscn") var startingStage:String
var curStage:Stage

func _ready() -> void:
	loadStage(startingStage)

#STAGE LOGIC
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
	
	setPlayerPosition()

func setPlayerPosition():
	player.global_position = curStage.GetPlayerPos()

#INVENTORY LOGIC
func updateInventoryUI():
	inventoryUI.updateItems()

func getSelectedItem():
	return inventoryUI.getSelectedItem()

func openInventoryUI():
	inventoryUI.setBoxActive()

func closeInventoryUI():
	inventoryUI.setBoxInactive()

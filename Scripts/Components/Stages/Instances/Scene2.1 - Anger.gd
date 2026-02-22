extends Node2D

@onready var tutorial = $TutorialInventory

func _ready() -> void:
	tutorial.visible = false
	checkInventory()

func checkInventory():
	if InventoryManager.inventory.size() > 0:
		tutorial.visible = true

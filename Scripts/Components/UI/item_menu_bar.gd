extends Control

@onready var itemObj = preload("res://Game Components/UI/item_menu.tscn")

@onready var itemContainer = $HBoxContainer
@onready var animation = $AnimationPlayer

func setBoxActive():
	animation.play("appear")
	
	var firstItem = itemContainer.get_child(0)
	firstItem.setFocused()

func setBoxInactive():
	animation.play("disappear")

func getSelectedItem():
	var btn_focused = get_viewport().gui_get_focus_owner()
	var item = btn_focused.get_parent()
	
	if item is not ItemMenu:
		return null
	
	return item.getItem()

func updateItems():
	clearItems()
	
	var inventory:Array[Item] = InventoryManager.inventory
	
	for item in inventory:
		var instance = itemObj.instantiate()
		itemContainer.add_child(instance)
		instance.setItem(item)

func clearItems():
	for item in itemContainer.get_children():
		item.queue_free()

extends Node

var inventory:Array[Item] = []

func addItem(item:Item):
	if inventory.find(item) != -1:
		return
	
	inventory.append(item)

func removeItem(item:Item):
	var foundID = inventory.find(item)
	
	if foundID != -1:
		inventory.remove_at(foundID)

func clearInventory():
	inventory.clear()

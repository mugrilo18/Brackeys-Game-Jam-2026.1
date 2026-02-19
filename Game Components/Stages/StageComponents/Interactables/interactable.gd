extends Area2D

class_name Interactable

@export var autoTrigger:bool = false
@export var deleteAfter:bool = false

@export_group("Dialogue")
@export var NormalDialogue:Dialogue #What usually plays when interacting
@export var gaveItemDialogue:Dialogue #If a item is given, play this dialogue now

@export_group("Item")
@export var correctItem:Item
@export var CorrectItemDialogue:Dialogue #If you use the correctItem
@onready var WrongItemDialogue:Dialogue = preload("res://Game Components/Dialogue/Instances/UsedWrongItem.tres") #If you use the wrongItem, load generic text

var gaveItem = false

func giveItem():
	gaveItem = true

func getNormalDialogue() -> Dialogue:
	if gaveItem:
		return gaveItemDialogue
	
	return NormalDialogue

func checkItem(item:Item) -> Dialogue:
	if item.ID != correctItem.ID:
		return WrongItemDialogue
	
	return CorrectItemDialogue

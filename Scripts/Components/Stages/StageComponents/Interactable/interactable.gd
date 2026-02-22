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
var currentDialogue:Dialogue = NormalDialogue

signal correctItemTriggered
signal interactedTriggered
signal startedInteraction

func giveItem():
	gaveItem = true

func getNormalDialogue() -> Dialogue:
	if gaveItem:
		currentDialogue = gaveItemDialogue
		return gaveItemDialogue
	
	currentDialogue = NormalDialogue
	return NormalDialogue

func checkItem(item:Item) -> Dialogue:
	if correctItem == null or item.ID != correctItem.ID:
		currentDialogue = WrongItemDialogue
		return WrongItemDialogue
	
	currentDialogue = CorrectItemDialogue
	return CorrectItemDialogue

func playStartSignal():
	startedInteraction.emit()

func playSignal():
	if currentDialogue == CorrectItemDialogue:
		correctItemTriggered.emit()
	else:
		interactedTriggered.emit()

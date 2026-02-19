extends Area2D

class_name Interactable

@export var autoTrigger:bool = false
@export var deleteAfter:bool = false

@export_category("Dialogue")
@export var InteractDialogue:Dialogue
@export var CorrectItemDialogue:Dialogue
#Var correctItem:Item

#func checkItem(Item) -> Dialogue:
	#if Item.ID != correctItem.ID:
		#return LoadGenericItemText
	#
	#return CorrectItemDialogue

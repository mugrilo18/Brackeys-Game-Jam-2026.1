extends Panel

class_name ItemMenu

@export var panelNormal:StyleBoxFlat
@export var panelSelected:StyleBoxFlat

@onready var imageObj = $TextureRect
@onready var labelObj = $Label
@onready var btn = $Button

var thisItem:Item = null

func setItem(item:Item):
	imageObj.texture = item.image
	labelObj.text = item.name
	
	thisItem = item

func setFocused():
	btn.call_deferred("grab_focus")

func getItem() -> Item:
	return thisItem

func _on_button_focus_entered() -> void:
	add_theme_stylebox_override("panel", panelSelected)

func _on_button_focus_exited() -> void:
	add_theme_stylebox_override("panel", panelNormal)

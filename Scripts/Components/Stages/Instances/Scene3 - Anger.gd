extends Node2D

@onready var tutorial = $TutorialInventory
@onready var audio = $AudioStreamPlayer

@export var interactableGate:Interactable
@export var gateOpen:AnimatedSprite2D

func _ready() -> void:
	tutorial.visible = false
	gateOpen.visible = false
	checkInventory()

func checkInventory():
	if InventoryManager.inventory.size() > 0:
		tutorial.visible = true

func _on_interactable_template_correct_item_triggered() -> void:
	tutorial.visible = false
	interactableGate.queue_free()
	
	gateOpen.visible = true
	gateOpen.play("default")
	audio.play()
	gateOpen.animation_finished.connect(endGame)

func endGame():
	AudioSettings.stopMusic()
	Transition.transitionToScene("res://Scenes/thxForPlaying.tscn")

extends Node2D

class_name Stage

@export var stageAmbiance:AudioStream

@onready var camera = $Camera2D
@onready var npcGrp = $NPCs
@onready var stageChangers = $StageChangers

var playerRef:Player
var gameRef:MainGame

var changedStage = false

func _ready() -> void:
	if stageAmbiance != null:
		AudioSettings.call_deferred("setNewMusic", stageAmbiance)

func _process(delta: float) -> void:
	if playerRef != null:
		camera.global_position = playerRef.global_position

func GetPlayerPos(changerID) -> Vector2:
	if has_node("PlayerSpawner"):
		return GetPlayerSpawnerPos()
	
	return stageChangers.get_child(changerID-1).global_position
	
	return Vector2(0, 0)

func GetPlayerSpawnerPos() -> Vector2:
	var spawner:Marker2D = get_node("PlayerSpawner")
	return spawner.global_position

func getPlayer(player:Player):
	playerRef = player

func getGame(game:MainGame):
	gameRef = game

func playNPCEvent(event:DialogueEvents):
	for npc in npcGrp.get_children():
		if npc.getNPCKey() == event.entityKey:
			npc.playNPCEvent(event)

func _on_npc_event_done() -> void:
	playerRef.advanceDialogue()

func _on_stage_changer_stage_changed(newStage: Variant, newSpawnID: Variant) -> void:
	if changedStage:
		return
	
	changedStage = true
	gameRef.transitionStage(newStage, newSpawnID)

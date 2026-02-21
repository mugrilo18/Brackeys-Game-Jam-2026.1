extends Node2D

class_name Stage

@onready var camera = $Camera2D

var playerRef:Player

func _process(delta: float) -> void:
	if playerRef != null:
		camera.global_position = playerRef.global_position

func GetPlayerPos() -> Vector2:
	if has_node("PlayerSpawner"):
		return GetPlayerSpawnerPos()
	
	return Vector2(0, 0)

func GetPlayerSpawnerPos() -> Vector2:
	var spawner:Marker2D = get_node("PlayerSpawner")
	return spawner.global_position

func getPlayer(player:Player):
	playerRef = player

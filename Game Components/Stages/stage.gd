extends Node2D

class_name Stage

func GetPlayerPos() -> Vector2:
	if has_node("PlayerSpawner"):
		return GetPlayerSpawnerPos()
	
	return Vector2(0, 0)

func GetPlayerSpawnerPos() -> Vector2:
	var spawner:Marker2D = get_node("PlayerSpawner")
	return spawner.global_position

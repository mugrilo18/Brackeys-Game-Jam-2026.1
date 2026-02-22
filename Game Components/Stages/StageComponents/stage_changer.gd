extends Area2D

@export_file("*.tscn") var stageToTransition:String
@export var spawnID:int = 0

signal stageChanged(newStage, newSpawnID)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		stageChanged.emit(stageToTransition, spawnID)

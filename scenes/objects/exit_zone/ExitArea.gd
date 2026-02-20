extends Area2D
class_name ExitArea

signal exit_level


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_set_collision_layers()

func _on_body_entered(body : Node2D) -> void:
	if body == LevelDriver.player:
		exit_level.emit()
		print("Exit level signal")

func _set_collision_layers() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)

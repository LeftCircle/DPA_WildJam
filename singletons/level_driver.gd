extends Node



var current_level : Level
var player : PlayerCharacter


func _on_level_exit():
	get_tree().change_scene_to_packed(current_level.next_level)

func _on_death_area_entered() -> void:
	print("Death Area entered")
	player.global_position = current_level.spawn_point.global_position

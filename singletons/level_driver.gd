extends Node

signal player_entered_cage()

var current_level : Level
var player : PlayerCharacter
var player_starting_state : PlayerStartingState = PlayerStartingState.new()

func _ready():
	player_starting_state.current_feathers = 1

func _on_level_exit():
	player_starting_state.current_feathers = player.feather_counter
	get_tree().change_scene_to_packed(current_level.next_level)

func _on_death_area_entered() -> void:
	print("Death Area entered")
	player._on_death()
	player.reset_feathers_to(player_starting_state.current_feathers)
	player.global_position = current_level.spawn_point.global_position

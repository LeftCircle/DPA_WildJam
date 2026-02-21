extends Node



var current_level : Level
var player : PlayerCharacter
var npcs : Dictionary[String, NPC] = {}
var player_starting_state : PlayerStartingState = PlayerStartingState.new()


func _ready():
	player_starting_state.current_feathers = 1

func register_npc(npc_name : String, _npc : NPC) -> void:
	npcs[name] = _npc

func remove_npc(name : String) -> void:
	pass

func _on_level_exit():
	player_starting_state.current_feathers = player.feather_counter
	get_tree().change_scene_to_packed(current_level.next_level)

func _on_death_area_entered() -> void:
	print("Death Area entered")
	player._on_death()
	player.reset_feathers_to(player_starting_state.current_feathers)
	player.global_position = current_level.spawn_point.global_position

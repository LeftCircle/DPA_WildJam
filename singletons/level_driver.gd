extends Node

signal player_entered_cage()

var current_level : Level
var player : PlayerCharacter
var npcs : Dictionary[String, NPC] = {}
var player_starting_state : PlayerStartingState = PlayerStartingState.new()

@onready var level_music : AudioStreamPlayer = $LevelMusic

func _ready():
	player_starting_state.current_feathers = 2
	level_music.bus = "Music"
	level_music.play()
	

func register_npc(npc_name : String, _npc : NPC) -> void:
	npcs[name] = _npc

func remove_npc(name : String) -> void:
	pass

func _on_level_exit():
	player_starting_state.current_feathers = player.feather_counter
	#get_tree().change_scene_to_packed(current_level.next_level)
	get_tree().call_deferred("change_scene_to_packed", current_level.next_level)
	player_starting_state.npcs_saved = player.npcs_saved
	player_starting_state.doomed = player.doomed
	get_tree().change_scene_to_packed(current_level.next_level)

func _on_death_area_entered() -> void:
	print("Death Area entered")
	player._on_death()
	player.reset_feathers_to(player_starting_state.current_feathers)
	#player.global_position = current_level.spawn_point.global_position
	get_tree().call_deferred("reload_current_scene")

func load_ending(ending: int) -> void:
	pass

func _on_level_music_finished():
	level_music.play(0.0)

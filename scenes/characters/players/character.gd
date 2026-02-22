extends CharacterBody2D
class_name PlayerCharacter

signal feather_used()
signal dash()
signal dash_finished()

var feather_counter = 99
var acquired_feathers : int = 99
var npcs_saved: Array[bool] = [false, false, false, false, false]
var doomed = false

@onready var camera = %Camera2D


func _ready():
	LevelDriver.player = self
	reset_feathers_to(LevelDriver.player_starting_state.current_feathers)
	reset_feathers_to(99)

func _physics_process(delta):
	_crumble_platforms()

func is_missing_feather() -> bool:
	return feather_counter < acquired_feathers

func _on_feather_pickup() -> void:
	feather_counter += 1
	acquired_feathers += 1

func _crumble_platforms() -> void:
	var coll : KinematicCollision2D = get_last_slide_collision()
	if is_instance_valid(coll) and is_instance_valid(coll.get_collider()):
		if coll.get_collider().has_method("crumble"):
			coll.get_collider().crumble()

func _on_death() -> void:
	pass

func reset_feathers_to(val : int) -> void:
	acquired_feathers = val
	feather_counter = val

func reset_doom_to(val : bool) -> void:
	doomed = val

func save_npc(val: int) -> void:
	npcs_saved[val] = true

func reset_saved_to(val : Array[bool]) -> void:
	npcs_saved = val

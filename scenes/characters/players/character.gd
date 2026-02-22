extends CharacterBody2D
class_name PlayerCharacter

signal feather_used()
signal dash()
signal dash_finished()
signal feather_collected()
signal reset_feathers()

var feather_counter = 99
var acquired_feathers : int = 99

func _ready():
	LevelDriver.player = self
	reset_feathers_to(LevelDriver.player_starting_state.current_feathers)

func _physics_process(delta):
	_crumble_platforms()

func is_missing_feather() -> bool:
	return feather_counter < acquired_feathers

func _on_feather_pickup() -> void:
	feather_counter += 1
	acquired_feathers += 1
	feather_collected.emit()

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

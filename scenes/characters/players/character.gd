extends CharacterBody2D
class_name PlayerCharacter

signal feather_used()
signal dash()
signal dash_finished()

var feather_counter = 99
var acquired_feathers : int = 99


func _ready():
	LevelDriver.player = self
	reset_feathers_to(LevelDriver.player_starting_state.current_feathers)
	reset_feathers_to(99)

func is_missing_feather() -> bool:
	return feather_counter < acquired_feathers

func _on_feather_pickup() -> void:
	feather_counter += 1
	acquired_feathers += 1

func _on_death() -> void:
	pass

func reset_feathers_to(val : int) -> void:
	acquired_feathers = val
	feather_counter = val

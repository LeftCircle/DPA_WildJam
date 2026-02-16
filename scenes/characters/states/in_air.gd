extends LimboState
class_name CharacterAirState

@export var char : CharacterBody2D

@onready var g = ProjectSettings.get("physics/2d/default_gravity")

func _update(delta : float) -> void:
	char.velocity.y += g * delta
	char.move_and_slide()

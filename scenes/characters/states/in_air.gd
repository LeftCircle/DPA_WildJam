extends LimboState
class_name CharacterAirState

@export var character : CharacterBody2D
@export var ground_state : LimboState

@onready var g = ProjectSettings.get("physics/2d/default_gravity")

func _update(delta : float) -> void:
	character.velocity.y += g * delta
	character.move_and_slide()
	if character.is_on_floor():
		get_root().change_active_state(ground_state)

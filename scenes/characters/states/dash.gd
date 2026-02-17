extends CharacterState
class_name DashState

@export var dash_frames : int = 4
@export var dash_speed : float = 3000
@export var input_processor : InputProcessor

var _current_dash_frames : int = 0
var _dash_direction : Vector2 = Vector2.ZERO

func _enter():
	_dash_direction = input_processor.get_input_dir()
	_dash_direction.y = 0
	_current_dash_frames = 0

func _update(delta : float) -> void:
	character.velocity = _dash_direction * dash_speed
	character.move_and_slide()
	_current_dash_frames += 1
	if _current_dash_frames >= dash_frames:
		dispatch("dash_to_ground")

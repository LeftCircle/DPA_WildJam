extends CharacterState
class_name JumpState


@export var jump_duration : float = 10
@export var jump_max_speed : float = 1500
@export var jump_curve : Curve
@export var air_state : CharacterAirState

var _current_jump_time : float = 0

func _enter():
	_current_jump_time = 0

func _update(delta):
	_current_jump_time += delta
	if _current_jump_time > jump_duration:
		state_machine.change_active_state(air_state)
	else:
		var curve_point = jump_curve.get_point_position(_current_jump_time / jump_duration)
		character.velocity.y = curve_point * jump_max_speed
		character.move_and_slide()
	

func _exit():
	_current_jump_time = 0

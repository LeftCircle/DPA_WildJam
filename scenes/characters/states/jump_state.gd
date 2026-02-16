extends CharacterState
class_name JumpState


@export var jump_duration : float = 10
@export var jump_max_speed : float = 1500
@export var jump_curve : Curve
@export var air_state : CharacterAirState
@export var horizontal_movement : HorizontalMovement = load("res://resources/character/PlayerHorizontalMovement.tres")
@export var input_processor : InputProcessor

var _current_jump_time : float = 0

func _enter():
	_current_jump_time = 0

func _update(delta):
	_current_jump_time += delta
	if _current_jump_time > jump_duration or not Input.is_action_pressed("jump"):
		dispatch("jump_to_air")
	else:
		var curve_point = jump_curve.sample(_current_jump_time / jump_duration)
		var new_y : float = (curve_point * jump_max_speed)
		character.velocity.y = -new_y
		character.velocity.x = horizontal_movement.tick(delta, input_processor.input_dir, character.velocity.x)
		character.move_and_slide()

func _exit():
	_current_jump_time = 0

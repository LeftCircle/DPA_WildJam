extends Node
class_name InputProcessor

var input_dir : Vector2

func _physics_process(delta):
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func get_input_dir() -> Vector2:
	return input_dir

func is_dash_queued() -> bool:
	return Input.is_action_just_pressed("dash")

func is_jump_queued() -> bool:
	return Input.is_action_just_pressed("jump")

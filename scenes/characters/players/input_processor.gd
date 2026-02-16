extends Node
class_name InputProcessor

var input_dir : Vector2

func _physics_process(delta):
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

extends Node
class_name MoveToPositionOnHit

@export var node_to_move : Node2D
@export var target_positions : Array[Node2D]
@export var velocity : float = 128

var _next_target_index : int = -1

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var next_pos : Vector2 = target_positions[_next_target_index].global_position
	node_to_move.global_position = node_to_move.global_position.move_toward(next_pos, delta * velocity)
	if node_to_move.global_position.distance_squared_to(next_pos) < 0.1:
		_on_target_reached()

func _on_target_reached() -> void:
	set_physics_process(false)

func _on_hit_target_target_hit():
	if not is_physics_processing():
		if _next_target_index < target_positions.size() - 1:
			_next_target_index += 1
		else:
			_next_target_index -= 1
		_next_target_index = clamp(_next_target_index, 0, target_positions.size() - 1)
		set_physics_process(true)
	

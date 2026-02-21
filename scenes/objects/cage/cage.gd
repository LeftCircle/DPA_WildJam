extends Node2D
class_name Cage


@export var target_position : Node2D
@export var velocity : float = 128


func _ready():
	set_physics_process(false)

func _physics_process(delta):
	self.global_position = self.global_position.move_toward(target_position.global_position, delta * velocity)
	if self.global_position.distance_squared_to(target_position.global_position) < 0.1:
		set_physics_process(false)

func _on_hit_target_target_hit():
	set_physics_process(true)

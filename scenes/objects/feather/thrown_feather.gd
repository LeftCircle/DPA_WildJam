extends RigidBody2D
class_name ThrownFeather

@onready var pivot : Node2D = $Pivot

func _physics_process(delta):
	if get_contact_count() > 0:
		sleeping = true
	pivot.look_at(global_position + linear_velocity)

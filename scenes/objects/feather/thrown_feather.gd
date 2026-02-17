extends RigidBody2D
class_name ThrownFeather


func _physics_process(delta):
	if get_contact_count() > 0:
		sleeping = true

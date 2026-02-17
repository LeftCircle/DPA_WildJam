extends RigidBody2D



func _physics_process(delta):
	if get_contact_count() > 0:
		sleeping = true

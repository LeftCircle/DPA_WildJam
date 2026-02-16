extends Resource
class_name HorizontalMovement

@export_range(100, 10000) var speed = 100;
@export_range(100, 10000) var acceleration = 1500;
@export_range(2000, 10000) var decceleration = 5000;


func tick(delta : float, input_dir : Vector2, x_vel : float) -> float:
	var a : float = 0
	if abs(input_dir.x) < 0.001 or input_dir.x * x_vel < 0:
		a = decceleration
	else:
		a = acceleration
	var vel = Vector2(x_vel, 0)
	vel = vel.move_toward(input_dir * speed, a * delta)
	return vel.x

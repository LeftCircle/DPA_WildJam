extends CharacterState
class_name ThrowState


@export var projectile_ps : PackedScene
@export var input_processor : InputProcessor
@export var impulse_force : float = 5000
@export var throw_point : Node2D
@export var projectile_container : Node
@export_range(0.0, 1.0, 0.01) var hang_speed_mod : float = 0.25
@export var throw_impulse : float = 850

var projectile : ThrownFeather
var float_velocity : Vector2

func _enter():
	projectile = projectile_ps.instantiate()
	projectile.global_position = throw_point.global_position
	projectile_container.add_child(projectile)
	projectile.sleeping = true
	float_velocity = character.velocity * hang_speed_mod

func _update(delta : float) -> void:
	projectile.global_position = throw_point.global_position
	if !character.is_on_floor():
		_float()
	if input_processor.is_throw_released():
		projectile.apply_central_impulse(impulse_force * input_processor.last_input_dir)
		dispatch("throw_to_ground")
		_bounce_on_throw()

func _float() -> void:
	character.velocity = float_velocity
	character.move_and_slide()

func _bounce_on_throw() -> void:
	character.velocity = input_processor.last_input_dir.normalized() * throw_impulse
	character.move_and_slide()

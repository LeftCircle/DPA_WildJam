extends CharacterState
class_name ThrowState


@export var projectile_ps : PackedScene
@export var input_processor : InputProcessor
@export var impulse_force : float = 5000
@export var throw_point : Node2D
@export var projectile_container : Node
@export_range(0.0, 1.0, 0.01) var hang_speed_mod : float = 0.25
@export var throw_impulse : float = 850
@export var anim_tree : PlayerAnimationTree
@export var horizontal_movement : HorizontalMovement = load("res://resources/character/PlayerHorizontalMovement.tres")
@export var grav_scale = 1.25

var projectile : ThrownFeather
var float_velocity : Vector2
var _throw_dir : Vector2

@onready var g = ProjectSettings.get("physics/2d/default_gravity")


func _enter():
	pass

func _update(delta : float) -> void:
	#projectile.global_position = throw_point.global_position
	#if !character.is_on_floor():
	#	_float()
	character.velocity.y += g * delta * grav_scale
	character.velocity.x = horizontal_movement.tick(delta, input_processor.input_dir, character.velocity.x)
	character.move_and_slide()
	if input_processor.is_throw_released():
		_spawn_projectile()
		_throw_dir = throw_point.global_position.direction_to(throw_point.get_global_mouse_position())
		print("Throw dir = ", _throw_dir)
		projectile.apply_central_impulse(impulse_force * _throw_dir)
		dispatch("throw_to_ground")
		_bounce_on_throw()
		anim_tree.start_anim("Throw")

func _spawn_projectile() -> void:
	projectile = projectile_ps.instantiate()
	projectile.global_position = throw_point.global_position
	projectile_container.add_child(projectile)
	projectile.sleeping = true
	float_velocity = character.velocity * hang_speed_mod

func _float() -> void:
	character.velocity = float_velocity
	character.move_and_slide()

func _bounce_on_throw() -> void:
	if !character.is_on_floor():
		character.velocity -= _throw_dir * throw_impulse
		character.move_and_slide()

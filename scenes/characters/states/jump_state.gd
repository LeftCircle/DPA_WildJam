extends CharacterState
class_name JumpState


@export var jump_duration : float = 10
@export var particle_frames : int = 5
@export var jump_max_speed : float = 1500
@export var jump_curve : Curve
@export var air_state : CharacterAirState
@export var horizontal_movement : HorizontalMovement = load("res://resources/character/PlayerHorizontalMovement.tres")
@export var input_processor : InputProcessor
@export var jump_particles_ps : PackedScene


var _current_jump_time : float = 0
var _jump_frames : int = 0

func _enter():
	_current_jump_time = 0

func _update(delta):
	_current_jump_time += delta
	if _current_jump_time > jump_duration or not Input.is_action_pressed("jump"):
		dispatch("jump_to_air")
	else:
		var curve_point = jump_curve.sample(_current_jump_time / jump_duration)
		var new_y : float = (curve_point * jump_max_speed)
		character.velocity.y = -new_y
		character.velocity.x = horizontal_movement.tick(delta, input_processor.input_dir, character.velocity.x)
		character.move_and_slide()
		_emit_jump_dust()
		_jump_frames += 1

func _emit_jump_dust() -> void:
	if _jump_frames <= particle_frames:
		var particles : DustParticleController = jump_particles_ps.instantiate()
		character.add_child(particles)
		particles.dust_emit()
		print("Emitting Particles")
		

func _exit():
	_current_jump_time = 0
	_jump_frames = 0

extends CharacterState
class_name CharacterGroundState

signal clear_sound()

@export var horizontal_movement : HorizontalMovement = load("res://resources/character/PlayerHorizontalMovement.tres")
@export var input_processor : InputProcessor
@export var coyote_timer : CoyoteTimer
@export var anim_tree : PlayerAnimationTree

var is_idle : bool = false


func _ready():
	coyote_timer.frame_reached.connect(_on_coyote_frame_reached)

func _enter():
	anim_tree.start_anim("Idle")
	is_idle = true

func _update(delta : float):
	_play_animations()
	if !character.is_on_floor():
		coyote_timer.tick()
	_move(delta)
	if Input.is_action_just_pressed("jump"):
		dispatch("ground_to_jump")
	else:
		if character.is_on_floor() and character.velocity.length_squared() > 0:
			audio
			play_sound.emit(audio, 0.0)
		else:
			clear_sound.emit()

func _play_animations() -> void:
	if not is_idle and character.velocity == Vector2.ZERO:
		anim_tree.start_anim("Idle")
		is_idle = true
	elif is_idle and character.velocity != Vector2.ZERO:
		anim_tree.start_anim("Run")
		is_idle = false

func _move(delta : float) -> void:
	character.velocity.x = horizontal_movement.tick(delta, input_processor.input_dir, character.velocity.x)
	character.move_and_slide()

func _on_coyote_frame_reached():
	coyote_timer.reset()
	dispatch("ground_to_air")

func _exit():
	coyote_timer.reset()
	clear_sound.emit()

extends LimboState
class_name CharacterGroundState

@export_range(100, 10000) var speed = 100;
@export_range(100, 10000) var acceleration = 1500;
@export_range(2000, 10000) var decceleration = 5000;


@export var air_state : LimboState
@export var jump_state : LimboState
@export var character : CharacterBody2D
@export var input_processor : InputProcessor
@export var coyote_timer : CoyoteTimer

func _ready():
	coyote_timer.frame_reached.connect(_on_coyote_frame_reached)

func _update(delta : float):
	if !character.is_on_floor():
		coyote_timer.tick()
	else:
		_move(delta)
	if Input.is_action_just_pressed("jump"):
		get_root().change_active_state(air_state)

func _move(delta : float) -> void:
	var a : float = 0
	if abs(character.velocity.x) < 0.001 or character.velocity.dot(input_processor.input_dir) > 0:
		a = acceleration
	else:
		a = decceleration
	var og_vel = character.velocity
	character.velocity = character.velocity.move_toward(input_processor.input_dir * speed, a * delta)
	print(input_processor.input_dir)
	character.velocity.y = og_vel.y
	print(character.velocity)
	character.move_and_slide()


func _on_coyote_frame_reached():
	coyote_timer.reset()
	get_root().change_active_state(air_state)

func _exit():
	coyote_timer.reset()
	

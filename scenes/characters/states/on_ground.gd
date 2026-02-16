extends LimboState
class_name CharacterGroundState

@export_range(100, 1000) var speed = 100;
@export_range(100, 10000) var acceleration = 1500;


@export var air_state : LimboState
@export var character : CharacterBody2D
@export var coyote_timer : CoyoteTimer

func _ready():
	coyote_timer.frame_reached.connect(_on_coyote_frame_reached)

func _update(delta : float):
	if !character.is_on_floor():
		coyote_timer.tick()
	else:
		_move(delta)

func _move(delta : float) -> void:
	pass


func _on_coyote_frame_reached():
	coyote_timer.reset()
	get_root().change_active_state(air_state)

func _exit():
	coyote_timer.reset()
	

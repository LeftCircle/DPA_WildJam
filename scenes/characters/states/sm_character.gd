extends LimboHSM

@export var character : PlayerCharacter
@export var input_processor : InputProcessor

@onready var run : LimboState = $Run
@onready var in_air : LimboState = $InAir
@onready var dash : CharacterState = $DashState
@onready var throw : CharacterState = $ThrowState

func _ready():
	initialize(character)
	initial_state = run
	_create_transitions()
	set_active(true)

func _create_transitions() -> void:
	add_transition($OnGround, $JumpState, "ground_to_jump")
	add_transition($JumpState, $InAir, "jump_to_air")
	add_transition($InAir, $OnGround, "air_to_ground")
	add_transition($OnGround, $InAir, "ground_to_air")
	add_transition($InAir, $JumpState, "double_jump", _check_for_feather)
	add_transition(dash, run, "dash_to_ground")
	add_transition(throw, run, "throw_to_ground")

func _physics_process(delta):
	_try_to_dash()
	_try_to_throw()

func _try_to_dash() -> void:
	if input_processor.is_dash_queued():
		if _check_for_feather():
			change_active_state(dash)

func _try_to_throw() -> void:
	if input_processor.is_throw_queued() and _check_for_feather():
		change_active_state(throw)

func _check_for_feather() -> bool:
	var check = false
	if character.feather_counter >= 1:
		character.feather_counter -= 1
		check = true
	print("Current Feathers = ", character.feather_counter)
	return check
		

extends LimboHSM

@export var character : PlayerCharacter
@export var input_processor : InputProcessor

@onready var run : LimboState = $Run
@onready var in_air : LimboState = $InAir
@onready var dash : CharacterState = $DashState
@onready var throw : CharacterState = $ThrowState
@onready var jump_state : CharacterState = $JumpState

func _ready():
	initialize(character)
	initial_state = run
	_create_transitions()
	set_active(true)

func _create_transitions() -> void:
	add_transition(run, jump_state, "ground_to_jump")
	add_transition(jump_state, in_air, "jump_to_air")
	add_transition(in_air, run, "air_to_ground")
	add_transition(run, in_air, "ground_to_air")
	add_transition(in_air, jump_state, "double_jump", _check_for_feather)
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
		character.feather_used.emit()
	print("Current Feathers = ", character.feather_counter)
	return check
		

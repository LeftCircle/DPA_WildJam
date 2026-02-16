extends LimboHSM

@export var character : CharacterBody2D


@onready var on_ground : LimboState = $OnGround
@onready var in_air : LimboState = $InAir

func _ready():
	initialize(character)
	initial_state = on_ground
	_create_transitions()
	set_active(true)

func _create_transitions() -> void:
	add_transition($OnGround, $JumpState, "ground_to_jump")
	add_transition($JumpState, $InAir, "jump_to_air")
	add_transition($InAir, $OnGround, "air_to_ground")
	add_transition($OnGround, $InAir, "ground_to_air")

func _on_on_ground_change_to_in_air():
	change_active_state(in_air)

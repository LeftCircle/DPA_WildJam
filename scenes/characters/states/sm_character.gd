extends LimboHSM

@export var char : CharacterBody2D


@onready var on_ground : LimboState = $OnGround
@onready var in_air : LimboState = $InAir

func _ready():
	initialize(char)
	initial_state = on_ground
	set_active(true)


func _on_on_ground_change_to_in_air():
	change_active_state(in_air)

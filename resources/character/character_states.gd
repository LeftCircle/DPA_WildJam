extends Resource
class_name PlayerStates

enum STATES {
	JUMP,
	ON_GROUND,
	IN_AIR,
	DASH
}

@export var states : Dictionary[STATES, String] = {
	STATES.JUMP: "jump",
	STATES.ON_GROUND: "on_ground",
	STATES.IN_AIR: "in_air",
	STATES.DASH: "dash"
}

extends Node2D

@export var lock : HitTarget
@export var rotation_speed : float
@export var rotation_amount : float

enum {OPEN, CLOSED}

@onready var pivot_point : Node2D = $PivotPoint
@onready var state = CLOSED

func _ready() -> void:
	lock.target_hit.connect(_open_hatch)
	
func _process(delta: float) -> void:
	if(state == CLOSED):
		if(pivot_point.rotation > -PI/2):
			pivot_point.rotate(-0.1)
	
func _open_hatch():
	pass

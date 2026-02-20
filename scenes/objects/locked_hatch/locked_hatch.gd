extends Node2D

# In order to use this object, just put it into whatever scene you plan to have
# a locked hatch in. As long as a feather hits the hit target, it should work

@export var lock : HitTarget

enum {OPEN, CLOSED}

@onready var pivot_point : Node2D = $PivotPoint
@onready var hatch_body : StaticBody2D = $PivotPoint/StaticBody2D
@onready var collisionLayer : int = 7
@onready var state = CLOSED
@onready var rotation_amount : float = float(0.0)

func _ready() -> void:
	hatch_body.set_collision_layer_value(collisionLayer, true)
	lock.target_hit.connect(_open_hatch)
	
func _process(delta: float) -> void:
	if(state == CLOSED):
		if(pivot_point.rotation > -PI/2):
			pivot_point.rotate(rotation_amount)
	
func _open_hatch():
	if (state == CLOSED):
		rotation_amount = -0.1 
		state == OPEN
		hatch_body.set_collision_layer_value(collisionLayer, false)
		
		
	

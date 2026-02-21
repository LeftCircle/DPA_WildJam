extends Node2D

# In order to use this object, just put it into whatever scene you plan to have
# a locked hatch in. As long as a feather hits the hit target, it should work

@export var lock : HitTarget
@export var rotation_amount : float

enum {OPEN, CLOSED}

@onready var pivot_point : Node2D = $PivotPoint
@onready var hatch_body : CollisionShape2D = $PivotPoint/StaticBody2D/CollisionShape2D
@onready var state = CLOSED
@onready var rotation_amount_radian = rotation_amount * (PI/180)

func _ready() -> void:
	lock.target_hit.connect(_open_hatch)
	set_physics_process(false)
	
func _physics_process(delta: float) -> void:
	pivot_point.rotate(rotation_amount_radian * delta)
	if(pivot_point.global_rotation < -PI/2) :
		set_physics_process(false)
	
func _open_hatch():
	if (state == CLOSED):
		state == OPEN
		hatch_body.set_deferred("disabled", true)
		set_physics_process(true)
		
		
	

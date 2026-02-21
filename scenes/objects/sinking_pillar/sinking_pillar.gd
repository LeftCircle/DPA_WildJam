extends StaticBody2D

enum {ACTIVE, INACTIVE}

@onready var state = INACTIVE
@onready var final_position : Vector2
@onready var base_position  : Vector2 = self.global_position

@export var trigger : HitTarget
@export var move_magnitude : float = 100
@export var velocity : float = 128

func _ready() -> void:
	trigger.target_hit.connect(_open_door)
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	self.global_position = self.global_position.move_toward(final_position, delta * velocity)
	if self.global_position.distance_squared_to(final_position) < 0.1:
		set_physics_process(false)

func _open_door() -> void:
	if (state == INACTIVE) :
		set_physics_process(true)
	
		# Taking base position and adding a higher position to it; move_magnitude controls
		# how far down the pillar moves
		final_position = base_position
		final_position += Vector2(0,1) * move_magnitude
		
		state = ACTIVE

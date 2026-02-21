#To add a locked door to a scene, it must have a corresponding HitTarget object.
#When both are in the scene, change lock property in inspector to the HitTarget
#you would like the door to move on activation.
#
#Properties:
	#lock - The corresponding HitTarget that controls when the door goes up
	#move_magnitude - how much we will move in the y direction
	#velocity - how fast it will move

extends StaticBody2D

enum {OPEN, CLOSED}

@onready var state = CLOSED
@onready var final_position : Vector2
@onready var base_position = self.global_position

@export var lock : HitTarget
@export var move_magnitude : float = 100
@export var velocity : float = 128

func _ready() -> void:
	lock.target_hit.connect(_open_door)
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	self.global_position = self.global_position.move_toward(final_position, delta * velocity)
	if self.global_position.distance_squared_to(final_position) < 0.1:
		set_physics_process(false)

func _open_door() -> void:
	if (state == CLOSED) :
		set_physics_process(true)
	
		# Taking base position and adding a higher position to it; move_magnitude controls
		# how far up the door moves
		final_position = base_position
		final_position += Vector2(0,-1) * move_magnitude
		
		state = OPEN

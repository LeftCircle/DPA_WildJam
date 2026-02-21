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
@onready var base_position  : Vector2 = self.global_position
@onready var coll_shape : CollisionShape2D = $CollisionShape2D

@export var lock : HitTarget
@export var move_magnitude : float = 100
@export var velocity : float = 128
@export var can_dash_through : bool = false

func _ready() -> void:
	lock.target_hit.connect(_open_door)
	if (can_dash_through) :
		LevelDriver.player.dash.connect(_on_player_dash)
		LevelDriver.player.dash_finished.connect(_on_player_dash_finished)
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	self.global_position = self.global_position.move_toward(final_position, delta * velocity)
	if self.global_position.distance_squared_to(final_position) < 0.1:
		set_physics_process(false)

func _on_player_dash() -> void:
	coll_shape.set_deferred("disabled", true)

func _on_player_dash_finished() -> void:
	coll_shape.set_deferred("disabled", false)	

func _open_door() -> void:
	if (state == CLOSED) :
		set_physics_process(true)
	
		# Taking base position and adding a higher position to it; move_magnitude controls
		# how far up the door moves
		final_position = base_position
		final_position += Vector2(0,-1) * move_magnitude
		
		state = OPEN

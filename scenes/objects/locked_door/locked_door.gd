extends StaticBody2D

To add a locked door to a scene, it must have a corresponding HitTarget object.
When both are in the scene, change lock property in inspector to the HitTarget
you would like the door to move on activation.

Properties:
	lock - The corresponding HitTarget that controls when the door goes up
	move_magnitude - how much we will move in the y direction
	move_speed - how fast we will move

@export var lock : HitTarget
@export var move_magnitude : float
@export var move_speed : float

enum {OPEN, CLOSED}

@onready var state = CLOSED
@onready var target_position : Vector2 = self.position
@onready var resting_position : Vector2 = self.position
@onready var move_direction : Vector2 = Vector2(0,0)

func _ready() -> void:
	lock.target_hit.connect(_open_door)

func _process(delta: float) -> void:
	if(self.position.y > target_position.y):
		move_and_collide(move_direction * move_speed)
		
func _open_door() -> void:
	if (state == CLOSED):
		var unit_vector : Vector2 = Vector2(0,-1)
		move_direction = unit_vector
	
		unit_vector *= move_magnitude
		target_position += unit_vector
		
		state = OPEN
	

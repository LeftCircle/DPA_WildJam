extends Node2D
class_name Chandelier

# Drop into scene with a HitTarget and connect it to this object

enum {ACTIVE, DEACTIVE}

@onready var base_sprite : Sprite2D = $StaticBody2D/CollisionShape2D/Base
@onready var base_body : StaticBody2D = $StaticBody2D
@onready var final_position : Vector2
@onready var state = DEACTIVE

@export var target : HitTarget
@export var velocity : float = 128
@export var chain_length : float = 100

func _ready() -> void:
	target.target_hit.connect(_lower_chandelier)
	_play_fire_animations()
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	base_body.global_position = base_body.global_position.move_toward(final_position, delta * velocity)
	if base_body.global_position.distance_squared_to(final_position) < 0.1:
		set_physics_process(false)

func _lower_chandelier():
	if (state == DEACTIVE) :
		set_physics_process(true)
	
		# Taking base position and adding a lower position to it; chain_length controls
		# how far down the chandelier moves
		final_position = base_body.global_position
		final_position += Vector2(0,1) * chain_length
		
		state = ACTIVE
	

func _play_fire_animations() -> void:
	for child in base_sprite.get_children():
		if child.has_method("start"):
			child.start()
		

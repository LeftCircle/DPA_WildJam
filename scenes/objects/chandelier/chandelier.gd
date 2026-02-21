extends Node2D
class_name Chandelier

@export var target : HitTarget
@export var chain_length : float
@export var move_speed : float

enum {ACTIVE, INACTIVE}

@onready var base_sprite : Sprite2D = $StaticBody2D/CollisionShape2D/Base
@onready var base_body : StaticBody2D = $StaticBody2D
@onready var base_target_position = base_body.position
@onready var base_resting_position = base_body.position
@onready var state = INACTIVE
@onready var move_direction : Vector2 = Vector2(0, 0)

func _ready() -> void:
	target.target_hit.connect(_lower_chandelier)
	_play_fire_animations()
	set_physics_process(false)
	

func _physics_process(delta: float) -> void:
	if state == ACTIVE and base_body.position < base_target_position:
		base_body.move_and_collide(move_direction * move_speed * delta)
		

func _lower_chandelier():
	if (state == INACTIVE):
		print("lower")
		state = ACTIVE
		
		var unit_vector : Vector2 = Vector2(0, 1)
		move_direction = unit_vector
		
		base_target_position += unit_vector * chain_length
		
		print(base_resting_position.y)
		print(base_target_position.y)
		set_physics_process(true)

func _play_fire_animations() -> void:
	for child in base_sprite.get_children():
		if child.has_method("start"):
			child.start()
		

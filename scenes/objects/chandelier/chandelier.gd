extends Node2D
class_name Chandelier

@export var target : HitTarget
@export var chain_length : float
@export var move_speed : float

enum {ACTIVE, INACTIVE}

@onready var base_sprite : Sprite2D = $StaticBody2D/CollisionShape2D/Base
@onready var base_body : StaticBody2D = $StaticBody2D
@onready var base_target_position = base_body.position
@onready var state = INACTIVE
@onready var move_direction : Vector2 = Vector2(0, 0)

func _ready() -> void:
	target.target_hit.connect(_lower_chandelier)
	
	for child in base_sprite.get_children():
		if child.has_method("start"):
			child.start()

func _process(delta: float) -> void:
	if (self.position.y < base_target_position.y):
		print("something")
		base_body.move_and_collide(move_direction * move_speed)

func _lower_chandelier():
	if (state == INACTIVE):
		print("lower")
		state = ACTIVE
		
		var unit_vector : Vector2 = Vector2(0, 1)
		move_direction = unit_vector
		
		base_target_position += unit_vector * chain_length
		

extends StaticBody2D
class_name HitTarget

signal target_hit

enum {ACTIVE, DEACTIVE}

@onready var hit_target_area : Area2D = $Area2D
@onready var state = DEACTIVE

func _ready():
	hit_target_area.body_entered.connect(_on_area2D_body_entered)

func _on_area2D_body_entered(body):
	print("Feather hit target")
	state = ACTIVE
	target_hit.emit()

func _get_state():
	return state

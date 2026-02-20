extends Node2D

@export var lock : HitTarget

enum {OPEN, CLOSED}

func _ready() -> void:
	lock.target_hit.connect(_open_hatch)
	
func _open_hatch():
	print("Open hatch")

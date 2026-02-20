extends Node2D

@export var lock : HitTarget
@export var move_magnitude : float

enum {OPEN, CLOSED}

@onready var state = CLOSED

func _ready() -> void:
	lock.target_hit.connect(_open_door)

func _open_door() -> void:
	print(move_magnitude)
	print(lock)
	
	

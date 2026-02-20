extends Node2D

enum {OPEN, CLOSED}

@onready var state = CLOSED
@onready var lock : HitTarget = get_node(self.get_meta("Target"))
@onready var move_magnitude : float = self.get_meta("Move_Magnitude")

func _ready() -> void:
	lock.target_hit.connect(_open_door)

func _open_door() -> void:
	print(move_magnitude)
	print("This is target:", lock)

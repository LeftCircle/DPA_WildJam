extends Node2D
class_name Chandelier


func _ready() -> void:
	for child in get_children():
		if child.has_method("start"):
			child.start()

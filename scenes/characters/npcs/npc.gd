extends CharacterBody2D
class_name NPC

@export var sprite_index : int = 0

func _ready() -> void:
	$Sprite2D.frame = sprite_index


func _on_interactable_queue_scene_free() -> void:
	queue_free()

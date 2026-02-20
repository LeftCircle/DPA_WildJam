extends Area2D

class_name PlayerInteract

var can_interact : bool = false

func _ready() -> void:
	_set_collision_layers()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact"):
		var interactables : Array[Area2D] = get_overlapping_areas()
		if interactables.size() > 0:
			interactables[0].action()
		return

func _set_collision_layers() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(9, true)
	set_collision_mask_value(1, false)
	set_collision_mask_value(9, true)

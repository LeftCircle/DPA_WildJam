extends Area2D
class_name DeathZone

signal character_entered_death

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	character_entered_death.connect(LevelDriver._on_death_area_entered)
	_set_collision_layers()

func _on_body_entered(body : Node2D) -> void:
	character_entered_death.emit()
	
func _set_collision_layers() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(6, true)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)

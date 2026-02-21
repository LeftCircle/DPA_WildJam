extends StaticBody2D
class_name DashCollider

@onready var coll_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	LevelDriver.player.dash.connect(_on_player_dash)
	LevelDriver.player.dash_finished.connect(_on_player_dash_finished)
	LevelDriver.player_entered_cage.connect(_on_player_entered_cage)

func _on_player_dash() -> void:
	coll_shape.set_deferred("disabled", true)

func _on_player_dash_finished() -> void:
	coll_shape.set_deferred("disabled", false)

func _on_player_entered_cage() -> void:
	coll_shape.set_deferred("disabled", false)

func _set_collision_layers() -> void:
	set_collision_layer_value(1, false)
	set_collision_layer_value(7, true)
	set_collision_mask_value(1, false)

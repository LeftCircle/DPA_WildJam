extends StaticBody2D
class_name DashCollider

@onready var coll_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	LevelDriver.player.dash.connect(_on_player_dash)
	LevelDriver.player.dash_finished.connect(_on_player_dash_finished)

func _on_player_dash() -> void:
	print("Collider sees dash")
	coll_shape.disabled = true

func _on_player_dash_finished() -> void:
	coll_shape.disabled = false

extends StaticBody2D
class_name DashCollider



func _ready() -> void:
	LevelDriver.player.dash.connect(_on_player_dash)

func _on_player_dash() -> void:
	print("Collider sees dash")

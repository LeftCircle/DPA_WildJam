extends Area2D
class_name DashCollisionEnabler


func _on_body_entered(body):
	if body == LevelDriver.player:
		LevelDriver.player_entered_cage.emit()

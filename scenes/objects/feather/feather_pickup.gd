extends Area2D
class_name FeatherPickup


func _on_body_entered(body):
	if body == LevelDriver.player:
		queue_free()
		LevelDriver.player._on_feather_pickup()

extends Area2D

@export var level : int = 1

func _on_body_entered(body: Node2D) -> void:
	if( body == LevelDriver.player):
		LevelDriver.load_ending(level)

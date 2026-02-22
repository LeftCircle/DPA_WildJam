extends Node2D

@export var angular_speed := 0.5

func _process(delta):
	rotation += angular_speed * delta

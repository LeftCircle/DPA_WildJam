extends Node



var current_level : Level
var player : PlayerCharacter


func _on_death_area_entered() -> void:
	print("Death Area entered")

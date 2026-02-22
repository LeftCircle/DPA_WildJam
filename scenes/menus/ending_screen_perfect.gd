extends Control

@export var main_menu: PackedScene


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_main_menu_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_packed", main_menu)

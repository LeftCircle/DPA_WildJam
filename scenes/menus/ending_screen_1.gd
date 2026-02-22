extends Control

@export var main_menu: PackedScene

@export var dialogue_resource: DialogueResource

@export var dialogue_start: String = "start"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start, [self])


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_main_menu_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_packed", main_menu)

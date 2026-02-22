extends Area2D
class_name CutsceneTrigger

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(on_dialogue_end)

func on_dialogue_end(dialogue :DialogueResource) -> void:
	get_tree().paused = false
	queue_free()

func action() -> void:
	get_tree().paused = true
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start, [self])


func _on_body_entered(body: Node2D) -> void:
	print("something entered")
	if body == LevelDriver.player:
		action()

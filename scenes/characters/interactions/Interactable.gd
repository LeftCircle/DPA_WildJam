extends Area2D

signal queue_scene_free()

@export var dialogue_resource: DialogueResource

@export var dialogue_start: String = "start"

@export var feather_give: int = -1
@export var feather_take: int = 4

var first : bool = true

var done : bool = false

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(on_dialogue_end)
func check_feathers() -> bool:
	return (LevelDriver.player.acquired_feathers + feather_give) > 0

func give_feathers() -> void:
	LevelDriver.player.reset_feathers_to(LevelDriver.player.acquired_feathers + feather_give)

func take_feathers() -> void:
	LevelDriver.player.reset_feathers_to(LevelDriver.player.acquired_feathers + feather_take)
	
func disappear() -> void:
	done = true
	
func on_dialogue_end(dialogue :DialogueResource) -> void:
	if dialogue == dialogue_resource and done:
		queue_scene_free.emit()

func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start, [self])

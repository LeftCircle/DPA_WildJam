extends Area2D

@export var dialogue_resource: DialogueResource

@export var dialogue_start: String = "start"

@export var feather_give: int = -1
@export var feather_take: int = 4

func check_feathers() -> bool:
	var player_feather = 2
	return (player_feather + feather_give) > 0

func give_feathers() -> void:
	print(feather_give)

func take_feathers() -> void:
	print(feather_take)
func disappear() -> void:
	print("Goodbye")

var first : bool = true

func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start, [self])

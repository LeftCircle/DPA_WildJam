extends Node2D
class_name Scale

@export var dialogue_resource: DialogueResource

@export var dialogue_start: String = "start"

@export var ending_to_load : int = 0

var first : bool = true

var done : bool = false

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(on_dialogue_end)

func check_perfect() -> bool:
	return LevelDriver.player.is_perfect()


func check_saved_one() -> bool:
	return LevelDriver.player.saved_one()

func check_doomed() -> bool:
	return LevelDriver.player.doomed

func play_sfx() -> void:
	#passes an sfx to play
	pass

func give_feathers_drifter() -> void:
	LevelDriver.player.reset_feathers_to(1)

func gift_feathers() -> void:
	LevelDriver.player._on_feather_pickup()

func doom_player() -> void:
	LevelDriver.player.reset_doom_to(true)


func load_ending() -> void:
	LevelDriver.load_ending(ending_to_load)

func disappear() -> void:
	done = true
	
func on_dialogue_end(dialogue :DialogueResource) -> void:
	get_tree().paused = false
	if dialogue == dialogue_resource and done:
		pass

func action() -> void:
	get_tree().paused = true
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start, [self])


func _on_area_2d_body_entered(body):
	if body == LevelDriver.player:
		action()

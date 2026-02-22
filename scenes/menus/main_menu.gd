extends Control

@export var start_level: PackedScene


func _ready():
	$AnimationPlayer.play("Title")
	LevelDriver.title_music.play(1.95)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	#should probably initialize the level driver to a base set of params
	LevelDriver.reset_player()
	get_tree().call_deferred("change_scene_to_packed", start_level)
	

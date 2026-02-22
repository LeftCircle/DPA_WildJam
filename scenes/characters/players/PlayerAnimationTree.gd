extends Node
class_name PlayerAnimationTree


@export var input_processor : InputProcessor
@export var sprite_container : Node2D
@export var anim_player : AnimationPlayer

@onready var anim_sm : AnimationNodeStateMachinePlayback = get("parameters/playback")


func _physics_process(delta) -> void:
	if input_processor.last_input_dir.x > 0:
		sprite_container.scale.x = 1.0
	else:
		sprite_container.scale.x = -1.0

func start_anim(anim_name : StringName, reset: bool = false) -> void:
	if is_instance_valid(anim_player):
		if (anim_name == "Run" or anim_name == "Idle") and anim_player.current_animation == "Throw":
			if anim_player.is_playing():
				return
		anim_player.play("RESET")
		anim_player.seek(1)
		anim_player.play(anim_name)
		print("Plaing ", anim_name)

func is_playing(anim_name : StringName) -> bool:
	return anim_player.current_animation == anim_name


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Throw":
		anim_player.play("RESET")
		anim_player.seek(1)
		anim_player.play("Idle")

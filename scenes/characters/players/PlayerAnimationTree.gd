extends AnimationTree
class_name PlayerAnimationTree


@export var input_processor : InputProcessor
@export var sprite_container : Node2D

@onready var anim_sm : AnimationNodeStateMachinePlayback = get("parameters/playback")
@onready var animation_player : AnimationPlayer = get_node(anim_player)

func _physics_process(delta) -> void:
	if input_processor.last_input_dir.x > 0:
		sprite_container.scale.x = 1.0
	else:
		sprite_container.scale.x = -1.0

func start_anim(anim_name : StringName, reset: bool = false) -> void:
	#if is_instance_valid(anim_sm):
		#anim_sm.start(anim_name, reset)
		#print("Starting ", anim_name)
	if is_instance_valid(animation_player):
		animation_player.play(anim_name)

func is_playing(anim_name : StringName) -> bool:
	return anim_sm.get_current_node() == anim_name

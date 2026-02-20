extends AnimationTree
class_name PlayerAnimationTree


@export var input_processor : InputProcessor
@export var sprite_container : Node2D

@onready var anim_sm : AnimationNodeStateMachinePlayback = get("parameters/playback")


func _physics_process(delta) -> void:
	if input_processor.last_input_dir.x > 0:
		sprite_container.scale.x = 1.0
	else:
		sprite_container.scale.x = -1.0

func start_anim(anim_name : StringName, reset: bool = false) -> void:
	if is_instance_valid(anim_sm):
		anim_sm.start(anim_name, reset)

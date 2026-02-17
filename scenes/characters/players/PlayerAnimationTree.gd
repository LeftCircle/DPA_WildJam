extends AnimationTree
class_name PlayerAnimationTree


@onready var anim_sm : AnimationNodeStateMachinePlayback = get("parameters/playback")


func start_anim(anim_name : StringName, reset: bool = false) -> void:
	anim_sm.start(anim_name, reset)

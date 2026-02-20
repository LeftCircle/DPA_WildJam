extends Sprite2D

var change_after : int = 120
var _current_frames : int = 0

@onready var anim_player : AnimationPlayer = $AnimationPlayer

func start() -> void:
	await get_tree().create_timer(randf()).timeout
	anim_player.speed_scale = 0.5 + randf() * 1.25
	anim_player.active = true
	anim_player.play("Flicker")


func _physics_process(delta):
	_current_frames += 1
	if _current_frames >= change_after:
		anim_player.speed_scale = 0.5 + randf() * 1.25
		if randf() < 0.5:
			anim_player.play("Flicker", -1, -1, true)

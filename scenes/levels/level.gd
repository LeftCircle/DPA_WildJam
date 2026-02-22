extends Node2D
class_name Level

@export var next_level : PackedScene
@export var spawn_point : Node2D
@export var llc : Node2D
@export var urc : Node2D
@export var start_music : bool = false

@onready var exit_area : ExitArea = $ExitArea
@onready var camera : Camera2D = %Camera2D


func _ready():
	if start_music:
		LevelDriver.title_music.stop()
		LevelDriver.level_music.play()
	LevelDriver.current_level = self
	if is_instance_valid(exit_area):
		exit_area.exit_level.connect(LevelDriver._on_level_exit)
	set_camera_limits(llc.global_position, urc.global_position)


func set_camera_limits(llc : Vector2, urc : Vector2) -> void:
	camera.limit_left = llc.x
	camera.limit_right = urc.x
	camera.limit_bottom = llc.y
	camera.limit_top = urc.y

func _on_hit_target_target_hit():
	print("Target hit!!")

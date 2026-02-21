extends Node2D
class_name Level

@export var next_level : PackedScene
@export var spawn_point : Node2D

@onready var exit_area : ExitArea = $ExitArea


func _ready():
	LevelDriver.current_level = self
	exit_area.exit_level.connect(LevelDriver._on_level_exit)


func _on_hit_target_target_hit():
	print("Target hit!!")

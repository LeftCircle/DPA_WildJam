extends Node
class_name FeatherResetter

var _can_reset : bool = false

@export var player : PlayerCharacter

@onready var timer : Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	player.feather_used.connect(_on_character_feather_used)

func _physics_process(delta):
	if _can_reset and player.is_missing_feather() and player.is_on_floor():
		player.reset_feathers_to(player.acquired_feathers)
		player.reset_feathers.emit()


func _on_timer_timeout():
	_can_reset = true


func _on_character_feather_used():
	timer.start(0)
	_can_reset = false

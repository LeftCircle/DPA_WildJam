extends CharacterBody2D
class_name PlayerCharacter

signal feather_used()
signal dash()
signal dash_finished()
signal feather_collected()
signal reset_feathers()

@export var slow_time : float = 0.3

var feather_counter = 0
var acquired_feathers : int = 0
var npcs_saved: Array[bool] = [false, false, false, false, false]
var doomed = false
var _can_bullet_time : bool = true

@onready var camera = %Camera2D
@onready var bullet_time_timer : Timer = $BulletTimeDuration


func _ready():
	LevelDriver.player = self
	reset_feathers_to(LevelDriver.player_starting_state.current_feathers)

func _physics_process(delta):
	_crumble_platforms()
	_try_to_bullet_time()

func _try_to_bullet_time() -> void:
	if _can_bullet_time:
		if Input.is_action_just_pressed("bullet_time"):
			if feather_counter > 0:
				feather_counter -= 1
				feather_used.emit()
			Engine.time_scale = slow_time
			_can_bullet_time = false
			bullet_time_timer.start()
	if Input.is_action_just_released("bullet_time"):
		Engine.time_scale = 1.0

func is_missing_feather() -> bool:
	return feather_counter < acquired_feathers

func _on_feather_pickup() -> void:
	feather_counter += 1
	acquired_feathers += 1
	%FeatherStream.play(0.35)
	feather_collected.emit()

func _crumble_platforms() -> void:
	var coll : KinematicCollision2D = get_last_slide_collision()
	if is_instance_valid(coll) and is_instance_valid(coll.get_collider()):
		if coll.get_collider().has_method("crumble"):
			coll.get_collider().crumble()

func _on_death() -> void:
	pass

func reset_feathers_to(val : int) -> void:
	acquired_feathers = val
	feather_counter = val

func reset_doom_to(val : bool) -> void:
	doomed = val

func save_npc(val: int) -> void:
	npcs_saved[val] = true

func reset_saved_to(val : Array[bool]) -> void:
	npcs_saved = val


func _on_feather_resetter_reset_feathers():
	reset_feathers_to(acquired_feathers)
	reset_feathers.emit()
	_can_bullet_time = true


func _on_bullet_time_duration_timeout():
	Engine.time_scale = 1.0

extends CharacterBody2D
class_name PlayerCharacter

signal feather_used()
signal dash()
signal dash_finished()
signal feather_collected()
signal reset_feathers()
signal death_finished()

@export var slow_time : float = 0.3

var feather_counter = 0
var acquired_feathers : int = 0
var npcs_saved: Array[bool] = [false, false, false, false, false]
#var npcs_saved: Array[bool] = [true,true,true,true,true]
var doomed = false
var _can_bullet_time : bool = true

@onready var camera = %Camera2D
@onready var bullet_time_timer : Timer = $BulletTimeDuration
@onready var bullet_time_reset : Timer = $BulletTimeReset
@onready var anim_tree : PlayerAnimationTree = $AnimationTree
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var sm : LimboHSM = $SM_Character
@onready var feather_vfx : FeathersLight = $PlayerVFX/vfx_feathers_light


func _ready():
	LevelDriver.player = self
	reset_feathers_to(LevelDriver.player_starting_state.current_feathers)
	doomed = LevelDriver.player_starting_state.doomed
	npcs_saved = LevelDriver.player_starting_state.npcs_saved
	print("Doomed = ", doomed)
	print("Npc saved = ", npcs_saved)

func _physics_process(delta):
	_crumble_platforms()
	_try_to_bullet_time()

func _try_to_bullet_time() -> void:
	if _can_bullet_time:
		if Input.is_action_just_pressed("bullet_time"):
			#if feather_counter > 0:
				#feather_counter -= 1
				#feather_used.emit()
			Engine.time_scale = slow_time
			_can_bullet_time = false
			bullet_time_timer.start()
			bullet_time_reset.start()
	if Input.is_action_just_released("bullet_time"):
		Engine.time_scale = 1.0

func is_missing_feather() -> bool:
	return feather_counter < acquired_feathers

func is_doomed() -> bool:
	return doomed

func is_perfect() -> bool:
	for npc in npcs_saved:
		if !npc:
			return false
	return true

func saved_one() -> bool:
	for npc in npcs_saved:
		if npc:
			return true
	return false

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
	sm._on_death()

func reset_feathers_to(val : int) -> void:
	acquired_feathers = val
	feather_counter = val
	reset_feathers.emit()
	#feather_vfx.update_feathers_count(feather_counter)

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


func _on_bullet_time_reset_timeout():
	_can_bullet_time = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Death":
		death_finished.emit()


func _on_feather_used():
	#feather_vfx.update_feathers_count(feather_counter)
	pass

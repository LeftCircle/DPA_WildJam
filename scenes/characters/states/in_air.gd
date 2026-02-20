extends LimboState
class_name CharacterAirState

@export var character : CharacterBody2D
@export var ground_state : LimboState
@export var horizontal_movement : HorizontalMovement = load("res://resources/character/PlayerHorizontalMovement.tres")
@export var input_processor : InputProcessor
@export var anim_tree : PlayerAnimationTree
@export var anim_player : AnimationPlayer

@onready var g = ProjectSettings.get("physics/2d/default_gravity")

func _enter():
	#if not anim_tree.is_playing("DoubleJump"):
	#	anim_tree.start_anim("Falling")
	if anim_tree.is_playing("DoubleJump"):
		anim_player.queue("Falling")
	else:
		anim_tree.start_anim("Falling")

func _update(delta : float) -> void:
	_enter_fall_animation()
	character.velocity.y += g * delta
	character.velocity.x = horizontal_movement.tick(delta, input_processor.input_dir, character.velocity.x)
	character.move_and_slide()
	if character.is_on_floor():
		get_root().change_active_state(ground_state)
	if Input.is_action_just_pressed("jump"):
			if dispatch("double_jump"):
				anim_tree.start_anim("DoubleJump", true)
				#print("Double jump occured")
				pass

func _enter_fall_animation() -> void:
	if not anim_tree.is_playing("DoubleJump"):
		anim_tree.start_anim("Falling")

extends LimboState
class_name CharacterAirState

@export var character : CharacterBody2D
@export var ground_state : LimboState
@export var horizontal_movement : HorizontalMovement = load("res://resources/character/PlayerHorizontalMovement.tres")
@export var input_processor : InputProcessor
@export var animation_player : AnimationPlayer

@onready var g = ProjectSettings.get("physics/2d/default_gravity")


func _update(delta : float) -> void:
	character.velocity.y += g * delta
	character.velocity.x = horizontal_movement.tick(delta, input_processor.input_dir, character.velocity.x)
	character.move_and_slide()
	if character.is_on_floor():
		get_root().change_active_state(ground_state)
	if Input.is_action_just_pressed("jump"):
			if dispatch("double_jump"):
				animation_player.play("DoubleJump_00")
				animation_player.seek(0, true)
			

extends CharacterBody2D
class_name FeatherCharacter

# The feather character exists to allow the feather to path back to the character.
# This might be harder to implement with just a rigid body
enum STATES {THROWN, RESTING}

@onready var g = ProjectSettings.get("physics/2d/default_gravity")

var _state = STATES.THROWN

func _physics_process(delta):
	if _state == STATES.THROWN:
		_when_thrown(delta)
	else:
		pass

func _when_thrown(delta : float) -> void:
	velocity.y += g * delta
	var coll = move_and_collide(velocity * delta)
	if is_instance_valid(coll):
		_state = STATES.RESTING

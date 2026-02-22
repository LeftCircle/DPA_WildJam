extends LimboState
class_name CharacterState

@export var character : CharacterBody2D
@export var audio : AudioStream
@export var audio_start : float = 0.0

signal play_sound(sound : AudioStream, start_at : float)

func _ready():
	character = get_root().get_parent()

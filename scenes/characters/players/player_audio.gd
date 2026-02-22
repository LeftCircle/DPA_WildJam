extends AudioStreamPlayer
class_name PlayerAudio

@export var _frames_between : int = 10
@export var delayed : bool = false
var _frame : int = 0
var sound_to_queue : AudioStream
var _start_at : float

func _ready() -> void:
	if not delayed:
		set_physics_process(false)

func _physics_process(delta):
	_frame += 1
	if _frame >= _frames_between and is_instance_valid(sound_to_queue):
		_frame = 0
		stream = sound_to_queue
		play(_start_at)
		sound_to_queue = null

func _on_jump_state_play_sound(sound : AudioStream, start_at : float):
	stream = sound
	play(start_at)
	print("Playing audio")

func _play_sound(sound : AudioStream, start_at : float) -> void:
	if delayed:
		sound_to_queue = sound
		_start_at = start_at
	else:
		stream = sound
		play(start_at)


func _on_run_clear_sound():
	sound_to_queue = null

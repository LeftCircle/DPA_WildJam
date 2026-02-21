extends AudioStreamPlayer2D
class_name PlayerAudio


func _on_jump_state_play_sound(sound : AudioStream, start_at : float):
	stream = sound
	play(start_at)
	print("Playing audio")

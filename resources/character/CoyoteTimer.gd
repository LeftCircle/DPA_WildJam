extends Resource
class_name CoyoteTimer

signal frame_reached
@export var coyote_frames : int = 3

var _frame : int = 0

func reset() -> void:
	_frame = 0

func tick() -> void:
	_frame += 1
	if _frame == coyote_frames:
		frame_reached.emit()

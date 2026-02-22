extends CanvasLayer
class_name Transition

signal finished

@export var duration: float = 0.5
@export var top_layer: int = 100

@onready var rect: ColorRect = $ColorRect
@onready var mat: ShaderMaterial = rect.material as ShaderMaterial

var _time: float = 0.0
var _playing: bool = false
var _direction: int = 1

func _ready() -> void:

	layer = top_layer

	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	rect.offset_left = 0
	rect.offset_top = 0
	rect.offset_right = 0
	rect.offset_bottom = 0

	assert(mat != null, "Transition: ColorRect.material must be a ShaderMaterial")
	rect.visible = false

func wipe_out() -> void:
	_time = 0.0
	_direction = 1
	_playing = true
	rect.visible = true
	mat.set_shader_parameter("progress", 0.0)

func wipe_in() -> void:
	_time = 0.0
	_direction = -1
	_playing = true
	rect.visible = true
	mat.set_shader_parameter("progress", 1.0)

func _process(delta: float) -> void:
	if not _playing:
		return

	_time += delta

	var p: float = clampf(_time / maxf(duration, 0.001), 0.0, 1.0)
	p = p * p * (3.0 - 2.0 * p)

	if _direction == 1:
		mat.set_shader_parameter("progress", p)
	else:
		mat.set_shader_parameter("progress", 1.0 - p)

	if p >= 1.0:
		_playing = false
		finished.emit()

func change_scene_to_packed_with_wipe(next_scene: PackedScene) -> void:
	wipe_out()
	await finished

	get_tree().change_scene_to_packed(next_scene)
	await get_tree().process_frame

	wipe_in()

func change_scene_to_file_with_wipe(path: String) -> void:
	wipe_out()
	await finished

	get_tree().change_scene_to_file(path)
	await get_tree().process_frame

	wipe_in()

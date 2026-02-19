extends Node2D

@onready var light: Light2D = $Light

@export var target: CanvasItem

@export_group("light setting")
@export var min_scale: float = 1.0
@export var max_scale: float = 3.0

@export_group("tests")
@export_range(1, MAX_COUNT, 1) var _test_count: int = 0:
	set(value):
		_test_count = value
		if is_node_ready():
			update_feathers_count(_test_count)

@export var _test_bool: bool = false:
	set(value):
		_test_bool = value
		if is_node_ready():
			update_light_state(_test_bool)

const MAX_COUNT := 20
var _level: float = 0.0
var _current_count = 0;
var _dimmed_color: Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_level = (max_scale-min_scale)/MAX_COUNT	
	var cm_node = get_tree().root.find_child("CanvasModulate", true, false)
	if cm_node is CanvasModulate:
		_dimmed_color = cm_node.color
	update_light_state(false);
	
func _process(delta: float) -> void:
	pass

# light update ( 1-20 )
func update_feathers_count(count: int) -> void:
	if not is_node_ready() or light == null or count < 1: 
		return
	_current_count = count
	light.texture_scale = min_scale+( _level * _current_count)
	update_light_state(true)
	print("count = ", _current_count, "  texture_scale = ", light.texture_scale)

# light turn on or turn off
func update_light_state(is_on: bool):
	if not is_node_ready() or light == null: 
		return
	if target:
		light.visible = is_on
		target.modulate = Color.WHITE if is_on else _dimmed_color

extends CanvasLayer

@onready var num_feathers : int
@onready var hbox : HBoxContainer = $MarginContainer/HBoxContainer
@onready var hbox_separation : int = hbox.get_theme_constant("separation")

@export var featherUIItem : PackedScene
@export var player : PlayerCharacter

func _ready() -> void:
	num_feathers = player.feather_counter
	for feather in range(num_feathers):
		_add_feather()
		
	player.feather_collected.connect(_on_feather_collected)
	player.feather_used.connect(_on_feather_used)
	player.reset_feathers.connect(_on_reset)

func _on_feather_collected() -> void:
	_add_feather()
	num_feathers += 1

func _on_feather_used() -> void:
	_remove_feather()
	num_feathers -= 1

func _on_reset() -> void:
	hbox.set_deferred("theme_override_constants/separation", 4)
	hbox_separation = 4
	
	for child in hbox.get_children():
		hbox.remove_child(child)
		
	for feather in range(LevelDriver.player.feather_counter):
		_add_feather()
		
func _add_feather() -> void:
	var box_item = featherUIItem.instantiate() as PanelContainer
	hbox.add_child(box_item)
	
	if (hbox.get_child_count() > 5):
		hbox_separation -= 100/hbox.get_child_count()
		hbox.set_deferred("theme_override_constants/separation", hbox_separation)
		
func _remove_feather() -> void:
	var tempNode = hbox.get_child(0)
	hbox.remove_child(tempNode)
	
	if (hbox.get_child_count() > 5):
		hbox_separation += 100/hbox.get_child_count()
		hbox.set_deferred("theme_override_constants/separation", hbox_separation)


func _on_fullscreen_pressed():
	print("Fullscreen")
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

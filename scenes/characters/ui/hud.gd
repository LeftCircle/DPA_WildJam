extends CanvasLayer

@onready var num_feathers = LevelDriver.player_starting_state.current_feathers
@onready var hbox : HBoxContainer = $MarginContainer/HBoxContainer
@onready var hbox_separation : int = hbox.get_theme_constant("separation")
@onready var button : Button = $Button

@export var featherUIItem : PackedScene

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
		
func _on_button_pressed() -> void:
	_add_feather()
	num_feathers += 1
	if (num_feathers > 5):
		hbox_separation -= 100/num_feathers
		hbox.set_deferred("theme_override_constants/separation", hbox_separation)
	
func _add_feather():
	var box_item = featherUIItem.instantiate() as PanelContainer
	hbox.add_child(box_item)
		

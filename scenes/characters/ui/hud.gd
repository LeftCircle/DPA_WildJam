extends CanvasLayer

@onready var player : PlayerCharacter
@onready var num_feathers : int
@onready var hbox : HBoxContainer = $MarginContainer/HBoxContainer
@onready var hbox_separation : int = hbox.get_theme_constant("separation")

@export var featherUIItem : PackedScene

func _ready() -> void:
	num_feathers = LevelDriver.player_starting_state.current_feathers
	for feather in range(num_feathers):
		_add_feather()
		
	LevelDriver.player.feather_collected.connect(_on_feather_collected)
	

func _on_feather_collected() -> void:
	_add_feather()
	num_feathers += 1
	
func _add_feather():
	var box_item = featherUIItem.instantiate() as PanelContainer
	hbox.add_child(box_item)
	if (num_feathers > 5):
		hbox_separation -= 100/num_feathers
		hbox.set_deferred("theme_override_constants/separation", hbox_separation)
		

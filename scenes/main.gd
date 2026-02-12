extends Node2D
class_name Main


# Here's a very quick overview of the bread and butter of godot. The mian parts are
# _init(), _ready(), and _physics_process()

# You've got your _init() function. This is called BEFORE the node enters the
# scene tree. This is called top down.
func _init() -> void:
	pass

# The _ready() function is called when the node enters the scene tree. This is
# called bottom up (children _ready() nodes are called before parent's _ready())
func _ready() -> void:
	pass

# Process occurs every draw frame. Not a great place to put game logic because
# dt varies.
func _process(delta: float) -> void:
	pass

# _physics_process occurs every physics frame. It has a fixed dt and is a great place
# to put game logic. It's safe to say that _physics_process occurs once per tick
func _physics_process(delta: float) -> void:
	pass

# This is where we handle user input. Most nodes don't need it.
func _input(event: InputEvent) -> void:
	pass

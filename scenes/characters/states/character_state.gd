extends LimboState
class_name CharacterState

@export var character : CharacterBody2D

func _ready():
	character = get_root().get_parent()

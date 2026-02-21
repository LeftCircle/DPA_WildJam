extends CharacterBody2D
class_name NPC

func _ready() -> void:
	LevelDriver.register_npc(self.name, self)

func _exit_tree() -> void:
	LevelDriver.remove_npc(self.name)

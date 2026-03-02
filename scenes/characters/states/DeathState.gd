extends CharacterState
class_name DeathState



@export var anim_tree : PlayerAnimationTree



func _enter():
	anim_tree.start_anim("Death")
	await character.death_finished

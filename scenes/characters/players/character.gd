extends CharacterBody2D
class_name PlayerCharacter

var feather_counter = 99


func _ready():
	$AnimationTree.active = true

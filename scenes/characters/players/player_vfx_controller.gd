extends Node2D
class_name PlayerVFX
@onready var feather_light: FeathersLight = $vfx_feathers_light
@export var jump_dust_particles : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# feather light
func get_feather_light() -> FeathersLight:
	return feather_light
	
# dust
func dust_emitting(position: Vector2) -> void:
	var particles : Node2D = jump_dust_particles.instantiate()
	particles.global_position = position
	get_tree().current_scene.add_child(particles)
	particles.particle_emit()
	

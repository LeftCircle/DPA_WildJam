extends Node2D
class_name PlayerVFX
@export var jump_dust_particles : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# dust
func dust_emitting(position: Vector2) -> void:
	var particles : Node2D = jump_dust_particles.instantiate()
	get_tree().current_scene.add_child(particles)
	particles.global_position = position
	particles.particle_emit()
	

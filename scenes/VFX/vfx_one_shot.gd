@tool
extends Node2D
class_name DustParticleController

@onready var particle: GPUParticles2D = $Particle

@export_tool_button("Test Emit")
var test_button := particle_emit

func particle_emit() -> void:
	particle.one_shot = true
	particle.emitting = true

func particle_finished():
	queue_free()

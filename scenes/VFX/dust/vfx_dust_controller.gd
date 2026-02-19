@tool
extends Node2D
class_name DustParticleController

@onready var dust: GPUParticles2D = $Dust

@export_tool_button("Test Emit")
var test_button := dust_emit

func dust_emit() -> void:
	dust.emitting = true

func dust_finished():
	print("Should queue free")
	queue_free()

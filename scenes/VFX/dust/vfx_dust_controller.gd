@tool
extends Node2D

@onready var dust: GPUParticles2D = $Dust

@export_tool_button("Test Emit")
var test_button := dust_emit

func dust_emit() -> void:
	if dust:
		dust.restart()
		dust.emitting = true

func dust_finished():
	queue_free()

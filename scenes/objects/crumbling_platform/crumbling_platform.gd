extends StaticBody2D
class_name CrumblingPlatform

@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Super janky but called from the player
func crumble() -> void:
	anim_sprite.play("PinkCrumble")


func _on_animated_sprite_2d_animation_finished():
	queue_free()

extends StaticBody2D


func _ready():
	var hit_target_area = get_node("Area2D")
	hit_target_area.connect("body_entered", _on_area2D_body_entered)
	
func _process(delta):
	pass

func _on_area2D_body_entered(body):
	print("Feather hit target")

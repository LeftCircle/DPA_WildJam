extends Button


func _on_pressed():
	self.hide()
	await get_tree().physics_frame
	show()

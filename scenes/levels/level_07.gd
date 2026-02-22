extends Level
class_name FinalLevel


func _ready() -> void:
	super._ready()
	var perfect = true
	if !LevelDriver.player.npcs_saved[0]:
		var npc = get_node("Characters/Braggart")
		npc.queue_free()
		perfect = false
	if !LevelDriver.player.npcs_saved[1]:
		var npc = get_node("Characters/Pragmatist")
		npc.queue_free()
		perfect = false
	if !LevelDriver.player.npcs_saved[2]:
		var npc = get_node("Characters/Drifter")
		npc.queue_free()
		perfect = false
	if !LevelDriver.player.npcs_saved[3]:
		var npc = get_node("Characters/Thief")
		npc.queue_free()
		perfect = false
	if !LevelDriver.player.npcs_saved[4]:
		var npc = get_node("Characters/Innocent")
		npc.queue_free()
		perfect = false
	if !perfect:
		var npc = get_node("Characters/OldMan2")
		npc.queue_free()

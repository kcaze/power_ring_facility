extends Area2D

func _ready():
	connect("body_enter", self, "_collide")
	
func _collide(other):
	if not "player" in other.get_groups():
		return
		
	var next_level = Globals.get('level_map')[Globals.get('current_level') + 1]
	get_tree().change_scene(next_level)
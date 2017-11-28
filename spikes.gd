extends Area2D

export var retractable = false

func _ready():
	set_process(true)
	if retractable:
		get_node('AnimationPlayer').play('retract')
		
func _process(delta):
	var player = get_tree().get_nodes_in_group('player')[0]
	if get_scale().y > 0.01 and overlaps_body(player):
		player.game_over()
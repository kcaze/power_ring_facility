extends Sprite

const power = preload('res://power.tscn')

onready var timer = get_node('Timer')
var child

func _ready():
	child = power.instance()
	add_child(child)
	timer.connect("timeout", self, "_spawn")
	set_process(true)

func _process(delta):
	var player = get_tree().get_nodes_in_group('player')[0]
	
	if not weakref(child).get_ref():
		spawn()
	
func spawn():
	child = power.instance()
	timer.set_wait_time(2.0)
	timer.start()
	
func _spawn():
	add_child(child)
	timer.stop()
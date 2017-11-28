extends Sprite

const power = preload('res://power.tscn')

export var period = 0.5
export var velocity = 100

onready var timer = get_node('Timer')

func _ready():
	timer.connect('timeout', self, 'shoot')
	timer.set_wait_time(period)
	timer.start()
	
func shoot():
	var p = power.instance()
	p.velocity = velocity * Vector2(-cos(get_rot()), sin(get_rot()))
	p.set_pos(get_pos())
	get_node('/root/root').add_child(p)
	timer.set_wait_time(period)
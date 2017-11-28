extends Area2D

const TEXTURE = preload('res://assets/player_power_ring.png')
const TEXTURE_BAD = preload('res://assets/player_power_ring_bad.png')

var velocity = Vector2(0, 0)

func _ready():
	set_process(true)
	connect("body_enter", self, "_collide")
	
func _process(delta):
	get_node('Sprite').rotate(-delta)
	translate(velocity * delta)
	
	if get_tree().get_nodes_in_group('player').size():
		var player = get_tree().get_nodes_in_group('player')[0]
		get_node('Sprite').set_texture(TEXTURE_BAD if player._power else TEXTURE)
	
func _collide(other):
	if "player" in other.get_groups():
		other._power = true
		queue_free()
	elif "wall" in other.get_groups():
		queue_free()


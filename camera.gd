extends Camera2D

const SCREENSHAKE_RADIUS = 5

func _ready():
	call_deferred('adjust_bottom_limit')
	set_process(true)
	
func adjust_bottom_limit():
	set_limit(MARGIN_BOTTOM, get_node('/root/root/goal').get_pos().y + 64)

func screenshake():
	set_offset(SCREENSHAKE_RADIUS * Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized())
	
func _process(delta):
	var r = max(get_offset().length() - 50*delta, 0)
	if r > 0:
		var angle = atan2(get_offset().x, get_offset().y) + rand_range(-100, 100)*delta
		set_offset(Vector2(r*sin(angle), r*cos(angle)))
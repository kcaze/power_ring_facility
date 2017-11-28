extends RigidBody2D

const MAX_HORIZONTAL_SPEED = 250
const HORIZONTAL_ACCELERATION = 250/2
const JUMP_IMPULSE = 1024
const TEXTURE = preload('res://assets/player.png')
const POWER_TEXTURE = preload('res://assets/player_power.png')

var _power = false setget set_power

func _ready():
	set_process_input(true)
	set_process(true)
	set_use_custom_integrator(true)
	set_can_sleep(false)
	
func set_power(new_power):
	if new_power and _power:
		game_over()
	if _power and not new_power:
		var ring_sprite = get_node('ScaleNode/RotationNode/RingSprite')
		ring_sprite.set_hidden(false)
		ring_sprite.get_node('AnimationPlayer').play('explode')
	_power = new_power
	get_node('ScaleNode/RotationNode/Sprite').set_texture(POWER_TEXTURE if _power else TEXTURE)
	
func _process(delta):
	var y_velocity = get_linear_velocity().y
	var scale = get_node('ScaleNode')
	if y_velocity > 0:
		scale.set_scale(Vector2(1, 1 + min(y_velocity / 2000, 0.3)))
	else:
		if scale.get_scale().y > 1.1:
			scale.set_scale(Vector2(1, 1.9 - scale.get_scale().y))
		else:
			scale.set_scale(Vector2(1, (4*scale.get_scale().y + 1)/5))
	if self._power:
		get_node('ScaleNode/RotationNode').rotate(-delta)

func _integrate_forces(state):
	state.integrate_forces()
	var linear_velocity = state.get_linear_velocity()
	if Input.is_action_pressed('ui_right'):
		linear_velocity.x = min(linear_velocity.x + HORIZONTAL_ACCELERATION, MAX_HORIZONTAL_SPEED)
	elif Input.is_action_pressed('ui_left'):
		linear_velocity.x = max(linear_velocity.x - HORIZONTAL_ACCELERATION, -MAX_HORIZONTAL_SPEED)
	state.set_linear_velocity(linear_velocity)
		
		
func _input(event):
	if event.is_action_pressed('ui_up') and _power:
		self.set_linear_velocity(Vector2(self.get_linear_velocity().x, 0))
		self.apply_impulse(Vector2(0, 0), Vector2(0, -1400))
		self._power = false

# TODO: Implement good game over
func game_over():
	get_tree().reload_current_scene()
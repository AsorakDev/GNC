extends State
class_name PlayerIdle

@onready var player = $"../.."
@onready var idle_buffer_timer = $"../../IdleBufferTimer"
@onready var airborne_input_buffer_timer = $"../../AirborneInputBufferTimer"
@onready var collision_standing = $"../../CollisionStanding"
@onready var collision_sliding = $"../../CollisionSliding"
@onready var ray_cast_2d = $"../../RayCast2D"
var left_pressed : bool = false
var right_pressed : bool = false

func stateEnter():
	player.direction = 0
	if not player.is_on_floor():
		airborne_input_buffer_timer.start()

func stateUpdate(delta):
	if not player.is_on_floor():
		collision_sliding.disabled = false
		collision_standing.disabled = true
		
	if ray_cast_2d.is_colliding():
		collision_sliding.disabled = true
		collision_standing.disabled = false
		
	apply_friction(delta)
	transition()

func stateExit():
	pass

func apply_friction(delta):
	if player.is_on_floor() and airborne_input_buffer_timer.is_stopped():
		player.velocity.x = move_toward(player.velocity.x, 0, delta * 1800)
		
func transition():
	if (Input.is_action_pressed("LM") and left_pressed or Input.is_action_pressed("RM") and right_pressed) and not idle_buffer_timer.is_stopped() and player.is_on_floor():
		idle_buffer_timer.stop()
		left_pressed = false
		right_pressed = false
		collision_sliding.disabled = true
		collision_standing.disabled = false
		state_transition.emit(self, "Attack")
	
	elif Input.is_action_pressed("LM") or Input.is_action_pressed("RM"):
		idle_buffer_timer.start()
		if Input.is_action_pressed("LM"):	left_pressed = true
		elif Input.is_action_pressed("RM"):	right_pressed = true
		state_transition.emit(self, "Move")

func _on_idle_buffer_timer_timeout():
	left_pressed = false
	right_pressed = false

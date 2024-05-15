extends State
class_name PlayerIdle

@onready var player = $"../.."
@onready var idle_buffer_timer = $"../../IdleBufferTimer"
var left_pressed : bool = false
var right_pressed : bool = false

func stateEnter():
	player.direction = 0

func stateUpdate(delta):
	apply_friction(delta)
	transition()

func stateExit():
	pass

func apply_friction(delta):
	player.velocity.x = move_toward(player.velocity.x, 0, delta * 1800)
		
func transition():
	if (Input.is_action_pressed("LM") and left_pressed or Input.is_action_pressed("RM") and right_pressed) and not idle_buffer_timer.is_stopped():
		idle_buffer_timer.stop()
		left_pressed = false
		right_pressed = false
		state_transition.emit(self, "Attack")
	
	elif Input.is_action_pressed("LM") or Input.is_action_just_pressed("RM"):
		idle_buffer_timer.start()
		if Input.is_action_pressed("LM"):	left_pressed = true
		elif Input.is_action_pressed("RM"):	right_pressed = true
		state_transition.emit(self, "Move")

func _on_idle_buffer_timer_timeout():
	left_pressed = false
	right_pressed = false

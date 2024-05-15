extends State
class_name PlayerSlide

@onready var player = $"../.."
@onready var slide_charge_timer = $"../../SlideChargeTimer"
@onready var slide_buffer_timer = $"../../SlideBufferTimer"
@onready var coyote_timer = $"../../CoyoteTimer"
@onready var collision_standing = $"../../CollisionStanding"
@onready var collision_sliding = $"../../CollisionSliding"

var buffer_timer_started : bool = false
var coyote_timer_started : bool = false
var buffered : bool = false
var can_jump : bool = true


func stateEnter():
	slide_charge_timer.start()
	collision_sliding.disabled = false
	collision_standing.disabled = true

func stateUpdate(delta):
	if (not Input.is_action_pressed("LM") or not Input.is_action_pressed("RM")) and not buffer_timer_started:
		slide_buffer_timer.start()
		buffer_timer_started = true
		buffered = true
	
	if not player.is_on_floor() and not coyote_timer_started:
		coyote_timer_started = true
		coyote_timer.start()
	
	elif player.is_on_floor():
		coyote_timer.stop()
		coyote_timer_started = false
		can_jump = true
	
	apply_friction(delta)
	transition()

func stateExit():
	coyote_timer.stop()
	slide_buffer_timer.stop()
	buffer_timer_started = false
	coyote_timer_started = false
	buffered = false
	can_jump = true

func apply_friction(delta):
	if abs(player.velocity.x) < 1200:
		player.velocity.x = move_toward(player.velocity.x, 0, delta * 900)

func transition():
	if not Input.is_action_pressed("LM") and not Input.is_action_pressed("RM") and buffered and can_jump:
		state_transition.emit(self, "Jump")
	
	elif (not Input.is_action_pressed("LM") or not Input.is_action_pressed("RM")) and not buffered:
		collision_sliding.disabled = true
		collision_standing.disabled = false
		state_transition.emit(self, "Move")

func _on_slide_buffer_timer_timeout():
	buffered = false

func _on_coyote_timer_timeout():
	can_jump = false

extends State
class_name PlayerMove

@onready var player = $"../.."
@onready var move_buffer_timer = $"../../MoveBufferTimer"
@onready var collision_standing = $"../../CollisionStanding"
@onready var collision_sliding = $"../../CollisionSliding"
var left_pressed : bool = false
var right_pressed : bool = false

func stateEnter():
	collision_sliding.disabled = true
	collision_standing.disabled = false

func stateUpdate(delta):
	transition()
	move(delta)

func stateExit():
	pass

func move(delta):
	if Input.is_action_pressed("LM"):	
		player.direction = -1
		left_pressed = true
	elif Input.is_action_pressed("RM"):	
		player.direction = 1
		right_pressed = true
		
	player.velocity.x = move_toward(player.velocity.x, player.move_speed * player.direction, delta * 2400)

func transition():
	if not Input.is_action_pressed("LM") and not Input.is_action_pressed("RM"):
		state_transition.emit(self, "Idle")
	
	elif Input.is_action_pressed("LM") and Input.is_action_pressed("RM") and player.is_on_floor():
		state_transition.emit(self, "Slide")
	
	elif Input.is_action_pressed("LM") and Input.is_action_pressed("RM") and not player.is_on_floor():
		if Input.is_action_just_pressed("LM"):
			player.facing_direction = 1
		elif Input.is_action_just_pressed("RM"):
			player.facing_direction = -1
		state_transition.emit(self, "Stomp")

func _on_move_buffer_timer_timeout():
	left_pressed = false
	right_pressed = false

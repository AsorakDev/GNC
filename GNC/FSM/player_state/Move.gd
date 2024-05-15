extends State
class_name PlayerMove

@onready var player = $"../.."

func stateEnter():
	pass

func stateUpdate(delta):
	transition()
	move(delta)

func stateExit():
	pass

func move(delta):
	if Input.is_action_pressed("LM"):	player.direction = -1
	elif Input.is_action_pressed("RM"):	player.direction = 1
	player.velocity.x = move_toward(player.velocity.x, player.move_speed * player.direction, delta * 2400)

func transition():
	if not Input.is_action_pressed("LM") and not Input.is_action_pressed("RM"):
		state_transition.emit(self, "Idle")

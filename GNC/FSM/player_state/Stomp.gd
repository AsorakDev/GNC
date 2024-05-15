extends State
class_name PlayerStomp

@onready var player = $"../.."
@onready var stomp_charge_up_timer = $"../../StompChargeUpTimer"
var vel : float 

func stateEnter():
	player.ignore_gravity = true
	vel = player.velocity.x
	player.velocity.x = 0.0
	stomp_charge_up_timer.start()

func stateUpdate(_delta):
	if stomp_charge_up_timer.is_stopped():
		player.velocity.y = 3600 
		
	else: 
		player.velocity.x = 0
		player.velocity.y = 0
	transition()

func stateExit():
	player.ignore_gravity = false
	stomp_charge_up_timer.stop()

func transition():
	if player.is_on_floor():
		if Input.is_action_pressed("LM") and Input.is_action_pressed("RM"):
			if vel > 0:
				player.velocity.x = 1200
			elif vel < 0:
				player.velocity.x = -1200
			state_transition.emit(self, "Slide")
		
		state_transition.emit(self, "Idle")

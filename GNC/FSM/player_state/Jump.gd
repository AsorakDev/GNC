extends State
class_name PlayerJump

@onready var player = $"../.."
@onready var slide_charge_timer = $"../../SlideChargeTimer"

func stateEnter():
	jump()

func stateUpdate(_delta):
	transition()

func stateExit():
	pass

func jump():
	player.velocity.y = -1600

func transition():
	state_transition.emit(self, "Idle")

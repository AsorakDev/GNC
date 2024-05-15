extends State
class_name PlayerStomp

@onready var player = $"../.."
@onready var stomp_charge_up_timer = $"../../StompChargeUpTimer"
@onready var collision_standing = $"../../CollisionStanding"
@onready var collision_sliding = $"../../CollisionSliding"
@onready var collision_shape_2d = $"../../StompAttackArea/CollisionShape2D"
var vel : float 

func stateEnter():
	collision_shape_2d.disabled = false
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
	collision_shape_2d.disabled = true
	stomp_charge_up_timer.stop()

func transition():
	if player.is_on_floor():
		if Input.is_action_pressed("LM") and Input.is_action_pressed("RM"):
			player.velocity.x = player.facing_direction * 1200
			state_transition.emit(self, "Slide")
		state_transition.emit(self, "Idle")
